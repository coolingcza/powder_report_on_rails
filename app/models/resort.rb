class Resort < ActiveRecord::Base
  
  attr_accessible :name, :latitude, :longitude, :state
  
  has_and_belongs_to_many :users
  
  validates :name, :latitude, :longitude, :state, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  
  # Public: .get_states
  # Returns the unique values from states field in resorts table.
  #
  # Parameters:
  # none.
  #
  # Returns: Array of hashes {"state" => unique record}. <-probably out of date
  
  def self.get_states
    results = self.select("distinct state")
  end
  
end
