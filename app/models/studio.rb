class Studio < ApplicationRecord
  has_many :movies
  has_many :actors, through: :movies, dependent: :destroy
  
  def unique_name
    actors.distinct.pluck(:name)
  end
end
