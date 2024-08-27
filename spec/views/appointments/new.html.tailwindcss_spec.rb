require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  let(:current_user) { create(:user, first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: 0) }

  let(:city) { City.create!(name: "Cidade dea Luz") }
  let(:local) { Local.create!(city: city, address: "Endereço de terste") }
  let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: false,
      user: user, price: 123, color: "Azul") }
  let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: user) }
  let(:user) { current_user }
  before(:each) do
    @current_user = current_user
    @appointment_type = appointment_type
    assign(:appointment, Appointment.new(
      appointment_code: DateTime.now.strftime("%Y%m%d%H%M%S") + rand(0..9).to_s,
      status: 0,
      appointment_type: appointment_type,
      local: local,
      pet: pet,
      client: user,
      start_at: Date.today,
      end_at: Date.today
    ))
  end


  it "renders new appointment form" do

    render

    expect(rendered).to match(/Client:/)

    expect(rendered).to match(@appointment_type.name)

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "select[name=?]", "appointment[pet_id]"

      #assert_select "input[name=?]", "appointment[appointment_type_id]"

      assert_select "input[name=?]", "appointment[notes]"

      assert_select "div", text: @appointment_type.name

      assert_select "input[name=?]", "appointment[start_at]"

      assert_select "input[name=?]", "appointment[end_at]"
    end
  end
end
