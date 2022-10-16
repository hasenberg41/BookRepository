require 'book_helper'

class BookRepresenter
  include BookHelper

  def initialize(book)
    @book = book
  end

  def as_json
    json(book)
  end

  private

  attr_reader :book
end
