require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST /create' do
    let(:user) { FactoryBot.create(:user) }
    let(:token) { AuthenticationTokenService.call(user.id) }

    it 'creating a new book' do
      author = FactoryBot.build(:author)
      book = FactoryBot.build(:book, 'author' => author)
      expect do
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
        }, headers: { 'Authorization' => "Token #{token}" }
      end.to change { Book.count }.from(0).to(1)

      expect(Author.count).to eq(1)
    end

    context 'should book saved with valid parameters' do
      let!(:author) { FactoryBot.create(:author) }
      let!(:test_book) { FactoryBot.create(:book, 'author' => author) }

      before do
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
        }, headers: { 'Authorization' => "Token #{token}" }
      end

      it 'returns the title' do
        expect(test_book.title).to eq(json['title'])
      end

      it 'returns the description' do
        expect(test_book.description).to eq(json['description'])
      end

      it 'returns correct author' do
        expect(test_book.author).to eq(author_from_response)
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
        }, headers: { 'Authorization' => "Token #{token}" }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
