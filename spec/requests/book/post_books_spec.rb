require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST /create' do

    it "create a new book" do
      author = FactoryBot.build(:author)
      book = FactoryBot.build(:book)
      expect {
        post '/api/v1/books', params: {
          book: {
            title: book.title,
            description: book.description
          },
          author: {
            first_name: author.first_name,
            last_name: author.last_name,
            age: author.age
          }
        }
      }.to change { Book.count }.from(0).to(1)

      expect(Author.count > 0)
    end

    context 'with valid parameters' do
      let!(:test_book) { FactoryBot.create(:book) }

      before do
        author = author_of(test_book)

        post '/api/v1/books', params: {
          book: {
            title: test_book.title,
            description: test_book.description
          },
          author: {
            first_name: author.first_name,
            last_name: author.last_name,
            age: author.age
          }
        }
      end

      it 'returns the title' do
        expect(test_book.title).to eq(json['title'])
      end

      it 'returns the description' do
        expect(test_book.description).to eq(json['description'])
      end

      it 'returns author' do
        author = Author.find(json['author_id'])
        expect(author_of(test_book)).to eq(author)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/books', params: {
          book: {
            title: '',
            description: ''
          },
          author: {
            first_name: '',
            last_name: '',
            age: 0
          }
        }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
