require 'rails_helper'

RSpec.describe "appointments/show", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: :client) }
  let(:city) { City.create!(name: "Cidade dea Luz") }
  let(:local) { Local.create!(city: city, address: "Endereço de terste") }
  let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: false,
      user: user, price: 123, color: "Azul") }
  let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: user) }
  let(:current_user) { user }
  before(:each) do
    #allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
    @current_user = current_user
    assign(:appointment, Appointment.create!(
      appointment_code: DateTime.now.strftime("%Y%m%d%H%M%S") + rand(0..9).to_s,
      status: 2,
      appointment_type: appointment_type,
      local: local,
      pet: pet,
      client: user,
      start_at: Date.today,
      end_at: Date.today

    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
