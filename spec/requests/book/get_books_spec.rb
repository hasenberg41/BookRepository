require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:book, 10)
      get '/api/v1/books'
    end

    it 'returns all books' do
      expect(10).to eq(json.size)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
