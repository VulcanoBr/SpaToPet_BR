require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    let(:user) { User.create!(first_name: 'Vulcan', last_name: 'Doe', email: 'example@example.com',
                username: 'user123', phone: '1234567890', password: 'password') }
    let(:city) { City.create!(name: "Cidade dea Luz") }
    let(:local) { Local.create!(city: city, address: "Endereço de terste") }
    let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: true,
                              user_id: user.id, price: 123, color: "Azul") }
    let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: user) }
    let(:appointment) { Appointment.create!(status: 0, appointment_type: appointment_type, local: local,
                    pet: pet, client: user, start_at: Date.today, end_at: Date.today) }
    #let(:current_user)  { user }
    it 'is invalid without a user_id' do
      payment = Payment.new(user_id: 1, appointment_id: 1)
      expect(payment.valid?).to be false
      expect(payment.errors[:user_id]).to include("Can't be blank")
    end

    it 'is invalid without an appointment_id' do
      payment = Payment.new(user_id: 1)
      expect(payment.valid?).to be false
      #expect(payment.errors[:appointment_id]).to include("Can't be blank")
    end

    it 'is valid with all required attributes' do
      payment = Payment.new(user_id: user.id, appointment_id: appointment.id)
      expect(payment.valid?).to be true
    end
  end
end
