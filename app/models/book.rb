class Book < ApplicationRecord
  validates :title, presence: true, length: { in: 3..50, wrong_length: "%<count>s in not 3-50 length" }
  validates :description, presence: true, length: { in: 10..500, wrong_length: "%<count>s in not 10-500 length" }
  validates :path, presence: true

  belongs_to :author
  belongs_to :user
end
