class User < ActiveRecord::Base
  
  attr_accessible :name, :password
  
  has_and_belongs_to_many :resorts
  
  validates :name, presence: true
  validates :password, presence: true
  
end
