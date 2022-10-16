require 'book_helper'

class BooksRepresenter
  include BookHelper

  def initialize(book)
    @books = book
  end

  def as_json
    books.map { |book| json(book) }
  end

  private

  attr_reader :books
end
