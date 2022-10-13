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
  end
end
