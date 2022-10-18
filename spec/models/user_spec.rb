require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'confirmation token' do
    let(:user) { FactoryBot.create(:user) }

    it 'email confirmation token should be created' do
      expect(user.confirm_token.blank?).to eq(false)
    end

    it 'email confirmation token should be in a database' do
      expect(user.confirm_token).to eq(User.find(user.id).confirm_token)
    end
  end
end
