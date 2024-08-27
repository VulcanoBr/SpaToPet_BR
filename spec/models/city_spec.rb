require 'rails_helper'

RSpec.describe City, type: :model do
  context 'validations' do
    it 'is invalid without a name' do
      city = City.new(name: nil)
      expect(city.valid?).to be(false)
      expect(city.errors[:name]).to include("Can't be blank")
    end

    it 'is valid with a name' do
      city = City.new(name: "São Paulo")
      expect(city.valid?).to be(true)
    end
  end
end
