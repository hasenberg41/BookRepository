require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST /create' do
    let(:user) { FactoryBot.create(:user) }
    let(:token) { AuthenticationTokenService.call(user.id) }

    it 'database should get a new book' do
      author = FactoryBot.build(:author, 'user' => user)
      book = FactoryBot.build(:book, 'author' => author)

      expect do
        post '/api/v1/books', params: {
          book: {
            title: book.title,
            description: book.description,
            path: book.path
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

    context 'book tests' do
      let!(:author) { FactoryBot.create(:author, 'user' => user) }
      let!(:book) { FactoryBot.create(:book, 'author' => author, 'user' => user) }

      context 'book and author should be have a user_id of creator' do
        before do
          post '/api/v1/books', params: {
            book: {
              title: book.title,
              description: book.description,
              path: book.path
            },
            author: {
              first_name: author.first_name,
              last_name: author.last_name,
              age: author.age
            }
          }, headers: { 'Authorization' => "Token #{token}" }
        end

        it 'author should be have a creator user_id' do
          expect(
            Author.find_by(
              first_name: author.first_name,
              last_name: author.last_name,
              user_id: user.id
            )
          ).to eq(author)
        end
      end

      context 'with valid parameters' do
        before do
          post '/api/v1/books', params: {
            book: {
              title: book.title,
              description: book.description,
              path: book.path
            },
            author: {
              first_name: author.first_name,
              last_name: author.last_name,
              age: author.age
            }
          }, headers: { 'Authorization' => "Token #{token}" }
        end

        it 'returns the title' do
          expect(book.title).to eq(json['title'])
        end

        it 'returns the description' do
          expect(book.description).to eq(json['description'])
        end

        it 'returns correct author' do
          expect(author_from_response).to eq(book.author)
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
              description: '',
              path: ''
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
end
