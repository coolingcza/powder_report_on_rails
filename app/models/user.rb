class User < ActiveRecord::Base
  
  has_secure_password
  has_and_belongs_to_many :resorts
  
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
end
