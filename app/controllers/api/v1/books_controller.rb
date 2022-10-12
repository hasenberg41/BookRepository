class Api::V1::BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :ok
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author)
  end
end
