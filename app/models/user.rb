VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

class User < ApplicationRecord
  before_create :confirmation_token

  validates :username, presence: true, length: { in: 3..100 }
  validates :email,
            presence: true,
            length: { in: 3..255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_many :authors
  has_many :books, through: :authors
  has_secure_password

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
