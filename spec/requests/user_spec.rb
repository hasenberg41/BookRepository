require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    let(:user) { FactoryBot.build(:user) }

    it 'returns http success' do
      post '/api/v1/registration', params: {
        user: {
          email: ENV['TEST_EMAIL_ADDRESS'].to_s,
          username: user.username,
          password: ('a'..'z').to_a.union((1..9).to_a).sample(9).join
        }
      }
      expect(response).to have_http_status(:created)
    end

    it 'returns http unprocessable_entity (422)' do
      post '/api/v1/registration', params: {
        user: {
          email: '',
          username: '',
          password: ''
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
