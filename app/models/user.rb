class User < ApplicationRecord
  has_secure_password

  has_many :user_requests
  has_many :advice_requests, through: :user_requests, source: :request
  has_many :requests
  belongs_to :request
  has_many :user_styles
  has_many :styles, through: :user_styles
  has_many :profile_photos
  has_many :comments


  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  # has_many :microposts, dependent: :destroy
  # has_many :active_relationships

  validates :username, :presence => { message: 'username' }
  validates :email, :presence => { message: 'email' },
              :format => { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , message: 'email format' },
              :uniqueness => { message: 'email uniqueness' }

                          # :confirmation => { message: 'password' },
                         # :length => { minimum: 4, message: 'password length must be over 4 characters' }

end
