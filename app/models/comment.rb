class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request
  belongs_to :request_photo
end
