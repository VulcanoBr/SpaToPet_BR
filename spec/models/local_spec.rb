require 'rails_helper'

RSpec.describe Local, type: :model do
  describe 'validations' do
    it 'is valid with a city_id and address' do
      city = City.create(name: 'Exemplo Cidade') # Assumindo que a cidade necessita apenas de um nome
      local = Local.new(city_id: city.id, address: '123 Example St')
      expect(local).to be_valid
    end

    it 'is invalid without a city_id' do
      local = Local.new(address: '123 Example St')
      local.valid?
      expect(local.errors[:city_id]).to include("Can't be blank")
    end

    it 'is invalid without an address' do
      city = City.create(name: 'Exemplo Cidade')
      local = Local.new(city_id: city.id)
      local.valid?
      expect(local.errors[:address]).to include("Can't be blank")
    end
  end
end
