class User < ApplicationRecord
  has_many :images
  validates :username, presence: true, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
end
