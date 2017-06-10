class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
end
