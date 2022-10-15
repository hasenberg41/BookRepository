class User < ApplicationRecord
  validates :username, presence: true, length: { in: 3..100 }
  has_secure_password
end
