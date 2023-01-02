# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
MovieActor.destroy_all

universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

toy_story = universal.movies.create!(title: 'Toy Story', creation_year: '1995', genre: 'animation')
minions = universal.movies.create!(title: 'Minions', creation_year: '2015', genre: 'animation')
jurassic_world = universal.movies.create!(title: 'Jurassic World Dominion', creation_year: '2022', genre: 'adventure')

venom = sony.movies.create!(title: 'Venom', creation_year: '2020', genre: 'action')
spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')