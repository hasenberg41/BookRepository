require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    let(:user) { FactoryBot.build(:user) }

    it 'returns http :success' do
      post '/api/v1/registration', params: {
        user: {
          email: user.email,
          username: user.username,
          password: ('a'..'z').to_a.union((1..9).to_a).sample(9).join
        }
      }
      expect(response).to have_http_status(:created)
    end

    it 'returns user id' do
      post '/api/v1/registration', params: {
        user: {
          email: user.email,
          username: user.username,
          password: ('a'..'z').to_a.union((1..9).to_a).sample(9).join
        }
      }
      expect(json).to eq({ 'user_id' => User.find_by(email: user.email).id })
    end

    it 'returns http :unprocessable_entity (422)' do
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

  describe 'confirm_email' do
    let!(:user) { FactoryBot.create(:user) }

    it 'returns http status :ok' do
      get '/api/v1/registration/confirm', params: { format: user.confirm_token }

      expect(response).to have_http_status(:ok)
    end

    it 'returns http status :not_found' do
      get '/api/v1/registration/confirm', params: { format: 'incorrect_token' }

      expect(response).to have_http_status(:not_found)
    end

    it 'user email must be confirmed when token correct' do
      get '/api/v1/registration/confirm', params: { format: user.confirm_token }

      expect(User.find(user.id).email_confirmed).to eq(true)
    end

    it 'user email must be confirmed when token incorrect' do
      get '/api/v1/registration/confirm', params: { format: 'incorrect_token' }

      expect(User.find(user.id).email_confirmed).to eq(false)
    end
  end

  describe 'send confirmation email' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns status :ok if user exist' do
      post '/api/v1/registration/confirm', params: { id: user.id }

      expect(response).to have_http_status(:ok)
    end

    it 'returns status :not_found if user dousnt exist' do
      post '/api/v1/registration/confirm', params: { id: rand(10_000) }

      expect(response).to have_http_status(:not_found)
    end
  end
end
