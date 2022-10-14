require 'rails_helper'

RSpec.describe 'Books', type: :request do
  BOOKS_COUNT = 300

  describe 'GET /index' do
    let!(:author) { FactoryBot.create(:author) }
    let!(:books) do
      FactoryBot.build_list(:book, BOOKS_COUNT) do |book|
        book.author = author
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

    it 'returns one correct book based on limit' do
      get '/api/v1/books', params: { limit: 1 }
      expect(json.size).to eq(1)

      book_like_responce = BookRepresenter.new(books[0]).as_json
      expect(json[0].to_json).to eq(book_like_responce.to_json)
    end

    it 'returns status code 200' do
      get '/api/v1/books', params: { limit: rand(1..99), offset: rand(1..(BOOKS_COUNT / 100)) }
      expect(response).to have_http_status(:success)
    end
  end
end
