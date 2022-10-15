require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'DELETE /destroy' do
    let!(:author) { FactoryBot.create(:author) }
    let!(:book) { FactoryBot.create(:book, 'author' => author) }

    before do
      user = FactoryBot.create(:user)
      @token = AuthenticationTokenService.call(user.id)
      delete "/api/v1/books/#{book.id}", headers: { 'Authorization' => "Token #{@token}" }
    end

    it 'Returns the status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'Authors should be a save in database' do
      expect(Book.count).to eq(0)
      expect(Author.count).to_not eq(0)
    end

    it 'Should deleted some book' do
      deleted_book = FactoryBot.create(:book, 'author' => author)
      expect do
        delete "/api/v1/books/#{deleted_book.id}", headers:
          { 'Authorization' => "Token #{@token}" }
      end.to change { Book.count }.from(1).to(0)
    end
  end
end
