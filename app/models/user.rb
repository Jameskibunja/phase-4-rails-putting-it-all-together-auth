class User < ApplicationRecord
    has_secure_password
  
    has_many :recipes
  
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, on: :create
    validates :image_url, presence: true
    validates :bio, presence: true
  end
  