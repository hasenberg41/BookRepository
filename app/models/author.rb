class Author < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 100, wrong_length: "%<count>s average them 100" }
  validates :last_name, presence: true, length: { maximum: 100, wrong_length: "%<count>s average them 100" }
  validates :age, presence: true, numericality: { in: 18..99 }
  has_many :books
end
