class Actor < ApplicationRecord
  has_many :movie_actors, dependent: :destroy
  has_many :movies, through: :movie_actors, dependent: :destroy
  has_many :studios, through: :movies, dependent: :destroy

  validates :name, uniqueness: true

  def self.age_sorted
    order(:age).pluck(:name)
  end

  def self.average_age
    average(:age)
  end
end