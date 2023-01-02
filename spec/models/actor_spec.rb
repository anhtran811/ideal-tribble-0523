require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many :movie_actors }
    it { should have_many(:movies).through(:movie_actors) }
    it { should have_many(:studios).through(:movies) }
  end
end