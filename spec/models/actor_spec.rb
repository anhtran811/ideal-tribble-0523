require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many :movie_actors }
    it { should have_many(:movies).through(:movie_actors) }
    it { should have_many(:studios).through(:movies) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name) }
  end

  describe '#age_sorted' do
    it 'can sort the actors in order of age' do
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

      expect(Actor.age_sorted).to eq([tom.name, zendaya.name, tobey.name, marisa.name])
    end
  end

  describe "#average_age" do
    it 'can calculate the average age of the actors in a movie' do
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

      expect(Actor.average_age).to eq(39.5)
    end
  end
end