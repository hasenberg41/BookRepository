require 'rails_helper'

BOOKS_COUNT = 300

RSpec.describe 'Books', type: :request do
  describe 'GET /index' do
    let(:user) { FactoryBot.create(:user) }
    let(:author) { FactoryBot.create(:author, 'user' => user) }
    let!(:books) do
      FactoryBot.build_list(:book, BOOKS_COUNT) do |book|
        book.author = author
        book.user = user
        book.save!
      end
    end

    it 'returns max books' do
      get '/api/v1/books', params: { limit: max_pagination_limit + 1 }
      expect(json.size).to eq(max_pagination_limit)
    end

    it "returns default count books (i'ts a max limit)" do
      get '/api/v1/books'
      expect(json.size).to eq(max_pagination_limit)
    end

    it 'returns one correct books based on random limit' do
      limit = rand(1..100)
      get '/api/v1/books', params: { limit: }
      expect(json.size).to eq(limit)

      (0..(limit - 1)).each do |i|
        book_like_responce = BookRepresenter.new(books[i]).as_json
        expect(json[i].to_json).to eq(book_like_responce.to_json)
      end
    end

    it 'returns correct json of book' do
      get '/api/v1/books', params: { limit: 1 }

      expect(json.first.to_json).to eq({
        id: books.first.id,
        title: books.first.title,
        description: books.first.description,
        path_url: books.first.path,
        author_name: "#{books.first.author.first_name} #{books.first.author.last_name}",
        author_age: books.first.author.age,
        user_creator: books.first.user.username
      }.to_json)
    end

    it 'returns status code 200' do
      get '/api/v1/books', params: { limit: rand(1..99), offset: rand(1..(BOOKS_COUNT / 100)) }
      expect(response).to have_http_status(:success)
    end
  end
end
