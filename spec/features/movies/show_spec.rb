require 'rails_helper'

# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors

RSpec.describe 'Movie show page' do
  describe 'User story 2' do
    it 'can show the movie title, creation year, and genre' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      visit "/movies/#{spider_man.id}"

      expect(page).to have_content(spider_man.title)
      expect(page).to have_content(spider_man.creation_year)
      expect(page).to have_content(spider_man.genre)
    end

    it 'can show the actors from youngest to oldest' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)
      marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
      tobey = Actor.create!(name: 'Tobey Maguire', age: 47)

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)
    
      visit "/movies/#{spider_man.id}"

      expect(tom.name).to appear_before(zendaya.name)
      expect(tobey.name).to appear_before(marisa.name)
      expect(marisa.name).to_not appear_before(tom.name)
    end

    it 'can show the average age of all actors' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)
      marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
      tobey = Actor.create!(name: 'Tobey Maguire', age: 47)

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)
    
      visit "/movies/#{spider_man.id}"

      expect(page).to have_content('Average actor age: 39.5years')    
    end
  end
end