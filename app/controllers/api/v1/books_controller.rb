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
    book = Book.new(book_params.merge(author_id: author.id, user_id: @user_id))

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
    @user_id = AuthenticationTokenService.decode(token)
    user = User.find(@user_id)

    if user.email_confirmed
      user
    else
      render json: { message: 'You need to verify your email to get access.' }, status: :unauthorized
    end
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
    params.require(:book).permit(:title, :description, :path)
  end

  def author_params
    params_hash = params.require(:author).permit(:first_name, :last_name, :age).to_h
    params_hash[:user_id] = @user_id
    params_hash
  end
end
