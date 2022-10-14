require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe "DELETE /destroy" do
    let!(:book) { FactoryBot.create(:book) }

    before do
      delete "/api/v1/books/#{book.id}"
    end

    it "Returns the status code 204" do
      expect(response).to have_http_status(204)
    end

    it "Authors should be a save in database" do
      expect(Author.count).to_not eq(0)
    end

    it "Should deleted some book" do
      deleted_book = FactoryBot.create(:book)
      expect {
        delete "/api/v1/books/#{deleted_book.id}"
      }.to change { Book.count }.from(1).to(0)
    end
  end
end
