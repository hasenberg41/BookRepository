module BookHelper
  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end

  def json(book)
    {
      id: book.id,
      title: book.title,
      description: book.description,
      author_name: author_name(book),
      author_age: book.author.age
    }
  end
end
