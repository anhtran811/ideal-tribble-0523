require 'rails_helper'

# As a user,
# When I visit a studio's show page
# I see the studio's name and location
# And I see a unique list of all of the actors that have worked on any of this studio's movies.

RSpec.describe 'Studio show page' do
  describe 'Extension' do
    it 'can show the studios name and location' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      venom = sony.movies.create!(title: 'Venom', creation_year: '2020', genre: 'action')
      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)
      marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
      tobey = Actor.create!(name: 'Tobey Maguire', age: 47)

      tom_h = Actor.create!(name: 'Tom Hardy', age: 45)
      michelle = Actor.create!(name: 'Michelle Williams', age: 42)

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)
      MovieActor.create!(movie_id: venom.id, actor_id: tom_h.id)
      MovieActor.create!(movie_id: venom.id, actor_id: michelle.id)

      visit "/studios/#{sony.id}"

      expect(page).to have_content(sony.name)
      expect(page).to have_content(sony.location)
    end
    
    it 'and unique list of all actors who worked at any movies in this studio' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      venom = sony.movies.create!(title: 'Venom', creation_year: '2020', genre: 'action')
      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)
      marisa = Actor.create!(name: 'Marisa Tomei', age: 58)
      tobey = Actor.create!(name: 'Tobey Maguire', age: 47)

      tom_h = Actor.create!(name: 'Tom Hardy', age: 45)
      michelle = Actor.create!(name: 'Michelle Williams', age: 42)

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: marisa.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: tobey.id)
      MovieActor.create!(movie_id: venom.id, actor_id: tom_h.id)
      MovieActor.create!(movie_id: venom.id, actor_id: michelle.id)
      MovieActor.create!(movie_id: venom.id, actor_id: tom.id)

      visit "/studios/#{sony.id}"

      expect(page).to have_content(tom.name, count: 1)
      expect(page).to have_content(tom_h.name)
      expect(page).to have_content(michelle.name)
      expect(page).to have_content(zendaya.name)
    end
  end
end