require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(first_name: 'Vulcan', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')
      pet = Pet.new(name: 'Rex', breed: 'Labrador', kind: :dog, user: user)
      expect(pet).to be_valid
    end

    it 'is invalid without a name' do
      pet = Pet.new(breed: 'Labrador', kind: :dog)
      expect(pet).not_to be_valid
      expect(pet.errors[:name]).to include("Can't be blank")
    end

    it 'is invalid without a breed' do
      pet = Pet.new(name: 'Rex', kind: :dog)
      expect(pet).not_to be_valid
      expect(pet.errors[:breed]).to include("Can't be blank")
    end

    it 'is invalid without a kind' do
      pet = Pet.new(name: 'Rex', breed: 'Labrador')
      expect(pet).not_to be_valid
      expect(pet.errors[:kind]).to include("Can't be blank")
    end
  end

  ### 2. Testando Enum
  describe "enum" do
    it "should only allow valid kind values" do
      invalid_kinds = [:invalid, "string", 5]
      invalid_kinds.each do |kind|
        user = User.create(first_name: 'Vulcan', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')

        expect {
          pet = Pet.new(name: "Fido", breed: "Poodle", kind: kind, user: user)
        }.to raise_error(ArgumentError, "'#{kind}' is not a valid kind")
      end
    end

    it "should be valid with a valid kind value" do
      valid_kinds = [:dog, :cat, :bird, :fish, :other]
      valid_kinds.each do |kind|
        user = User.create(first_name: 'Vulcan', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')
        pet = Pet.new(name: "Fido", breed: "Poodle", kind: kind, user: user)
        expect(pet).to be_valid
      end
    end
  end
end
