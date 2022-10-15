class Api::V1::BooksController < ApplicationController
  include ActionController::HttpAuthentication::Token
  MAX_PAGINATION_LIMIT = 100

  before_action :authenticate, only: %i[create destroy]

  def index
    books = Book.limit(limit).offset(params[:offset])
    render json: BooksRepresenter.new(books).as_json
  end

  def create
    author = Author.find_or_create_by(author_params)
    book = Book.new(book_params.merge(author_id: author.id))

    if book.save
      render json: BookRepresenter.new(book).as_json, status: :created
    else
      render json: book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end

  private

  def authenticate
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    render status: :unauthorized
  end

  def limit
    [
      params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
      MAX_PAGINATION_LIMIT
    ].min
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age)
  end
end
