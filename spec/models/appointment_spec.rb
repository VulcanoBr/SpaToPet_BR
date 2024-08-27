require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context "validations" do
    let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
      phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: 0) }
    let(:city) { City.create!(name: "Cidade dea Luz") }
    let(:local) { Local.create!(city: city, address: "Endereço de terste") }
    let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: true,
                                                    user: user, price: 123, color: "Azul") }
    let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: user) }
    let(:current_user)  { user }

    describe 'validations start_at and end_at' do

      it 'is not valid without an end_at' do
        appointment = Appointment.new(start_at: Time.now, client: User.new, appointment_type: AppointmentType.new, pet: Pet.new, local: Local.new)
        expect(appointment).not_to be_valid
        expect(appointment.errors[:end_at]).to include("Can't be blank")
      end

      it 'is not valid without a start_at' do
        appointment = Appointment.new(end_at: Time.now, client: User.new, appointment_type: AppointmentType.new, pet: Pet.new, local: Local.new)
        expect(appointment).not_to be_valid
        expect(appointment.errors[:start_at]).to include("Can't be blank")
      end

    end
    describe "ORDER_BY" do
      it "orders by newest (created_at DESC)" do
        appointments = create_list(:appointment, 3, status: 0, appointment_type_id: appointment_type.id,
          local_id: local.id, pet_id: pet.id, client_id: user.id, start_at: Date.today,
          end_at: Date.today + 1, created_at: Date.today)
        expect(Appointment.order(Appointment::ORDER_BY[:newest])).to eq(appointments)
      end

      it "orders by latest (created_at ASC)" do
        appointments = create_list(:appointment, 3, status: 0, appointment_type_id: appointment_type.id,
          local_id: local.id, pet_id: pet.id, client_id: user.id, start_at: Date.today,
          end_at: Date.today + 1)
        expect(Appointment.order(Appointment::ORDER_BY[:latest])).to eq(appointments)
      end
    end

    describe "enum" do
      it "has a status enum with scheduled, processing, and finished" do
        expect(Appointment.statuses.keys).to eq(["scheduled", "processing", "finished"])
      end

      it "allows setting status to valid enum values" do
        appointment = create(:appointment, status: 0, appointment_type_id: appointment_type.id,
        local_id: local.id, pet_id: pet.id, client_id: user.id, start_at: Date.today,
        end_at: Date.today + 1)
        appointment.status = :processing
        appointment.save
        expect(appointment.status).to eq("processing")
      end

      it "raises an error for invalid status values" do
        appointment = create(:appointment, status: 0, appointment_type_id: appointment_type.id,
        local_id: local.id, pet_id: pet.id, client_id: user.id, start_at: Date.today,
        end_at: Date.today + 1)
        expect { appointment.status = :invalid }.to raise_error(ArgumentError)
      end
    end
  end
end
