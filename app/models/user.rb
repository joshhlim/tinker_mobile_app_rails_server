class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # attr_accessible :username, :login
  # attr_accessor :login

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  # has_many :microposts, dependent: :destroy
  # has_many :active_relationships
  has_many :user_styles
  has_many :styles, through: :user_styles
  has_many :profile_photos
  has_many :requests

  def name
    email.split('@')[0]
  end

  # def self.find_for_database_authentication warden_conditions
  #   conditions = warden_conditions.dup
  #   login = conditions.delete(:login)
  #   where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  # end
end
