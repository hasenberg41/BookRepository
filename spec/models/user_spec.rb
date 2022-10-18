require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email confirmation' do
    let(:user) { FactoryBot.create(:user) }

    it 'email confirmation token should be created' do
      expect(user.confirm_token.blank?).to eq(false)
    end

    it 'email confirmation token should be in a database' do
      expect(user.confirm_token).to eq(User.find(user.id).confirm_token)
    end

    it 'email confirmed should be false by default' do
      expect(user.email_confirmed).to eq(false)
    end
  end
end
