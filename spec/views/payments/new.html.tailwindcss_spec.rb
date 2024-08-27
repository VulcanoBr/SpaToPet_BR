require 'rails_helper'

RSpec.describe "payments/new", type: :view do
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
    assign(:payment, Payment.new(
      billing_status: 6,
      user: user,
      appointment: appointment
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input[name=?]", "payment[billing_status]"

      assert_select "input[name=?]", "payment[user_id]"

      assert_select "input[name=?]", "payment[appointment_id]"
    end
  end
end
