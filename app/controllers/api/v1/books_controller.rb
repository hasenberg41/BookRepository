class Api::V1::BooksController < ApplicationController
  def index
    render json: BooksRepresenter.new(Book.all).as_json
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

  def book_params
    params.require(:book).permit(:title, :description)
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age)
  end
end
