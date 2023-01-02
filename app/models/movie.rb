class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors, dependent: :destroy
  has_many :actors, through: :movie_actors, dependent: :destroy
end
