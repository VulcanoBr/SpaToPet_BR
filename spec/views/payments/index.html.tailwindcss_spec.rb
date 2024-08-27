require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  let(:city) { City.create!(name: "Cidade dea Luz") }
  let(:local) { Local.create!(city: city, address: "Endereço de terste") }
  let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: true,
      user: user, price: 123, color: "Azul") }
  let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: user) }
  let(:appointment) { Appointment.create!(status: 0, appointment_type: appointment_type, local: local,
      pet: pet, client: user, start_at: Date.today, end_at: Date.today) }
  before(:each) do
    assign(:payments, [
      Payment.create!(
        billing_status: :unapproved,
        user: user,
        appointment: appointment
      ),
      Payment.create!(
        billing_status: :unapproved,
        user: user,
        appointment: appointment
      )
    ])
  end

  it "renders a list of payments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Billing Status:"), count: 2
    assert_select cell_selector, text: Regexp.new("User:"), count: 2
    assert_select cell_selector, text: Regexp.new("Appointment:"), count: 2
  end
end
