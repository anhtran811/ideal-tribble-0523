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

  # As a user,
  # When I visit a movie show page,
  # I do not see any actors listed that are not part of the movie
  # And I see a form to add an actor to this movie
  # When I fill in the form with the ID of an actor that exists in the database
  # And I click submit
  # Then I am redirected back to that movie's show page
  # And I see the actor's name is now listed
  # (You do not have to test for a sad path, for example if the id submitted is not an existing actor)
  describe 'User story 3' do
    it 'can add an actor to a movie' do 
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)
      marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
      tobey = Actor.create!(name: 'Tobey Maguire', age: 47)
      andrew = Actor.create!(name: 'Andrew Garfield', age: 39) 

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)
    
      visit "/movies/#{spider_man.id}"
      
      expect(page).to_not have_content(andrew.name)

      fill_in('Actor identification', with: "#{andrew.id}")
      click_on 'Add Actor'

      expect(current_path).to eq("/movies/#{spider_man.id}")
      expect(page).to have_content(andrew.name)
    end
  end
end