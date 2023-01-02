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

tom = Actor.create!(name: 'Tom Holland', age: 26)
zendaya = Actor.create!(name: 'Zendaya', age: 27)
marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
tobey = Actor.create!(name: 'Tobey Maguire', age: 47)

MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)