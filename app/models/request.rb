class Request < ApplicationRecord
  belongs_to :user
  has_many :request_photos
  has_many :request_tags
  has_many :user_requests
  has_many :advisors, through: :user_requests, class_name: "User"
end
