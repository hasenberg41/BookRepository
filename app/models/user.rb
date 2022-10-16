class User < ApplicationRecord
  validates :username, presence: true, length: { in: 3..100 }
  has_many :authors
  has_many :books, through: :authors
  has_secure_password
end
