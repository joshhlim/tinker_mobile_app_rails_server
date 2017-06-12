class Request < ApplicationRecord
  belongs_to :user
  has_many :request_photos
  has_many :request_tags
end
