class BooksRepresenter
  def initialize(book)
    @books = book
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        description: book.description,
        author_name: author_name(book),
        author_age: book.author.age
      }
    end
  end

  private

  attr_reader :books

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end
