require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'DELETE /destroy' do
    context 'email was confirmed' do
      let(:user) { FactoryBot.create(:user, email_confirmed: true) }
      let(:token) { AuthenticationTokenService.call(user.id) }
      let(:author) { FactoryBot.create(:author, 'user' => user) }
      let!(:book) { FactoryBot.create(:book, 'author' => author, 'user' => user) }

      before do
        delete "/api/v1/books/#{book.id}", headers: { 'Authorization' => "Token #{token}" }
      end

      it 'returns the status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'authors should be a save in database' do
        expect(Book.count).to eq(0)
        expect(Author.count).to_not eq(0)
      end

      it 'should deleted some book' do
        deleted_book = FactoryBot.create(:book, 'author' => author, 'user' => user)
        expect do
          delete "/api/v1/books/#{deleted_book.id}", headers:
            { 'Authorization' => "Token #{token}" }
        end.to change { Book.count }.from(1).to(0)
      end
    end

    context 'email didnt confirmed' do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { AuthenticationTokenService.call(user.id) }
      let(:author) { FactoryBot.create(:author, 'user' => user) }
      let!(:book) { FactoryBot.create(:book, 'author' => author, 'user' => user) }

      before do
        delete "/api/v1/books/#{book.id}", headers: { 'Authorization' => "Token #{token}" }
      end

      it 'returns http status :unauthorized and email confirmation message' do
        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq({ 'message' => 'You need to verify your email to get access.' })
      end
    end
  end
end
