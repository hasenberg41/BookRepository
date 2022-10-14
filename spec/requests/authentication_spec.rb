require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    it 'authenticate the client' do
      post '/api/v1/authenticate', params: { username: "BookSeller1", password: "password1" }

      expect(response).to have_http_status(:created)
      expect(json).to eq({'token' => 'this_is_test_token'})
    end

    it 'should return an error of username is doesnt exist' do
      post '/api/v1/authenticate', params: { password: "password1" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({ 'error' => 'param is missing or the value is empty: username' } )
    end

    it 'should return an error of password is doesnt exist' do
      post '/api/v1/authenticate', params: { username: "BookSeller1" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({ 'error' => 'param is missing or the value is empty: password' } )
    end
  end
end
