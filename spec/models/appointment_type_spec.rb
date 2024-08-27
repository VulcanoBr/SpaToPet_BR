require 'rails_helper'

RSpec.describe AppointmentType, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(first_name: 'Vulcan', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')
      appointment_type = build(:appointment_type, user: user)
      expect(appointment_type).to be_valid
    end

    it 'is not valid without a name' do
      appointment_type = build(:appointment_type, name: nil)
      expect(appointment_type).not_to be_valid
    end

    it 'is not valid without a user' do
      appointment_type = build(:appointment_type, user: nil)
      expect(appointment_type).not_to be_valid
    end

    it 'is not valid without a price' do
      appointment_type = build(:appointment_type, price: nil)
      expect(appointment_type).not_to be_valid
    end

    it 'normalizes name to lowercase' do
      appointment_type = build(:appointment_type, name: 'EMERGÊNCIA')
      expect(appointment_type.name).to eq('emergência')
    end
  end
end
