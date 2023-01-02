require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it { should have_many :movies }
    it { should have_many(:actors).through(:movies)}
  end

  describe "#unique_name" do
    it 'show actors names, only once' do
      sony = Studio.create!(name: 'Sony', location: 'Los Angeles')

      venom = sony.movies.create!(title: 'Venom', creation_year: '2020', genre: 'action')
      spider_man = sony.movies.create!(title: 'Spider Man No Way Home', creation_year: '2021', genre: 'action')

      tom = Actor.create!(name: 'Tom Holland', age: 26)
      zendaya = Actor.create!(name: 'Zendaya', age: 27)

      tom_h = Actor.create!(name: 'Tom Hardy', age: 45)
      michelle = Actor.create!(name: 'Michelle Williams', age: 42)

      MovieActor.create!(movie_id: spider_man.id, actor_id: tom.id)
      MovieActor.create!(movie_id: spider_man.id, actor_id: zendaya.id)
      MovieActor.create!(movie_id: venom.id, actor_id: tom_h.id)
      MovieActor.create!(movie_id: venom.id, actor_id: michelle.id)
      MovieActor.create!(movie_id: venom.id, actor_id: tom.id)

      expect(sony.unique_name.sort).to eq([michelle.name, tom_h.name, tom.name, zendaya.name,])
    end
  end
end
