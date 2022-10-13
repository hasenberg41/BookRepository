require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST /create' do

    it "create a new book" do
      book = FactoryBot.build(:book)
      expect {
        post '/api/v1/books', params: {
          book: {
            title: book.title,
            description: book.description,
            author: book.author
          }
        }
      }.to change { Book.count }.from(0).to(1)
    end

    context 'with valid parameters' do
      let!(:test_book) { FactoryBot.create(:book) }

      before do
        post '/api/v1/books', params: {
          book: {
            title: test_book.title,
            description: test_book.description,
            author: test_book.author
          }
        }
      end

      it 'returns the title' do
        expect(json['title']).to eq(test_book.title)
      end

      it 'returns the description' do
        expect(json['description']).to eq(test_book.description)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/books', params:
                          { book: {
                            title: '',
                            description: '',
                            author: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
