require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user) }
    let(:token) { AuthenticationTokenService.call(user.id) }

    it 'authenticate the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: user.password }

      expect(response).to have_http_status(:created)
      expect(json).to eq({'token' => token})
    end

    it 'should return an error of username is doesnt exist' do
      post '/api/v1/authenticate', params: { password: user.password }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({ 'error' => 'param is missing or the value is empty: username' } )
    end

    it 'should return an error of password is doesnt exist' do
      post '/api/v1/authenticate', params: { username: user.username }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({ 'error' => 'param is missing or the value is empty: password' } )
    end

    it 'should return an error of password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: "some_incorrect_pass" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
