require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    it 'returns http success' do
      # TODO
      expect(response).to have_http_status(:success)
    end
  end

end
