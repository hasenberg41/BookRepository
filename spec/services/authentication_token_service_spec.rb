require 'rails_helper'

describe AuthenticationTokenService do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { described_class.call(user.id) }

  describe '.call' do

    it 'returns an authentication token' do
      decoded_token = JWT.decode token, described_class::HMAC_SECRET, true,
        { algorithm: described_class::ALGORITHM_TYPE }

      expect(decoded_token).to eq([{"user_id"=>user.id}, {"alg"=>"HS256"}])
    end
  end

  describe '.decode' do
    it 'returns an user id' do
      expect(described_class.decode(token)).to eq(user.id)
    end
  end
end
