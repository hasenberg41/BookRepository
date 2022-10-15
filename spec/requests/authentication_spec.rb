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

  describe "Books controller specs, when token is incorrect" do
    let(:incorrect_token) { AuthenticationTokenService.call(rand(10..99)) }
    it "POST /books should return status code 401" do
      author = FactoryBot.build(:author)
      book = FactoryBot.build(:book, author: author)

      post '/api/v1/books', params: {
        book: {
          title: book.title,
          description: book.description
        },
        author: {
          first_name: author.first_name,
          last_name: author.last_name,
          age: author.age
        }
      }, headers: { "Authorization" => "Token #{incorrect_token}" }

      expect(response).to have_http_status(:unauthorized)
    end

  end
end
