require 'rails_helper'

# As a user,
# When I visit the studio index page,
# Then I see all of the studios including name and location,
# And under each studio I see all of the studio's movies
# including the movie's title, creation year, and genre
RSpec.describe 'Studio index page' do
  describe 'User story 1' do
    it 'can show the studios name, location, movies(with their title, creation yr, and genre' do
      universal = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      toy_story = universal.movies.create!(title: 'Toy Story', creation_year: '1995', genre: 'animation')
      minions = universal.movies.create!(title: 'Minions', creation_year: '2015', genre: 'animation')
      jurassic_world = universal.movies.create!(title: 'Jurassic World Dominion', creation_year: '2022', genre: 'adventure')
      
      venom = sony.movies.create!(title: 'Venom', creation_year: '2020', genre: 'action')
      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')
    
      visit '/studios'

      within("#studio-#{universal.id}") do
        expect(page).to have_content(universal.name)
        expect(page).to have_content(toy_story.title)
        expect(page).to have_content(minions.creation_year)
        expect(page).to have_content(jurassic_world.genre)
        expect(page).to_not have_content(venom.title)
      end
      
      within("#studio-#{sony.id}") do
        expect(page).to have_content(sony.name)
        expect(page).to have_content(venom.title)
        expect(page).to have_content(spider_man.title)
        expect(page).to_not have_content(jurassic_world.genre)
      end
    end
  end
end