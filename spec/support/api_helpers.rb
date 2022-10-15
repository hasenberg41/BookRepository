module ApiHelpers
  MAX_PAGINATION_LIMIT = 100

  def max_pagination_limit
    MAX_PAGINATION_LIMIT
  end

  def json
    JSON.parse(response.body)
  end

  def author_from_response
    f_name, l_name = json['author_name'].split
    Author.find_by(first_name: f_name, last_name: l_name)
  end
end
