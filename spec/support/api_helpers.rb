module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def author_of(book)
    book.author
  end
end
