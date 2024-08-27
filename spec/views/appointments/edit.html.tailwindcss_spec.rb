require 'rails_helper'

RSpec.describe "appointments/edit", type: :view do
  let(:current_user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: 0) }
  #let(:current_user) { user }
  let(:city) { City.create!(name: "Cidade dea Luz") }
  let(:local) { Local.create!(city: city, address: "Endereço de terste") }
  let(:appointment_type) { AppointmentType.create!(name: "Name test", payment_required: false,
      user: current_user, price: 123, color: "Azul") }
  let(:pet)  { Pet.create!(name: "Nome Teste", breed: "breed", kind: 1, user: current_user) }
  let(:appointment) {
    Appointment.create!(
      appointment_code: DateTime.now.strftime("%Y%m%d%H%M%S") + rand(0..9).to_s,
      status: 0,
      appointment_type: appointment_type,
      local: local,
      pet: pet,
      client: current_user,
      start_at: Date.today,
      end_at: Date.today
    )
  }



  before do
    # Simular login do usuário
    #allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end
  before(:each) do
    @current_user = current_user
    @appointment_type = appointment_type
    @appointment = appointment
  #  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)

  end

  it "renders the edit appointment form" do

    render

    expect(rendered).to match(/Client:/)

    expect(rendered).to match(@appointment.appointment_type.name)

    assert_select "form[action=?][method=?]", appointment_path(appointment), "post" do

      assert_select "select[name=?]", "appointment[pet_id]"

      #assert_select "input[name=?]", "appointment[appointment_type_id]"

      assert_select "input[name=?]", "appointment[notes]"

      assert_select "input[name=?]", "appointment[start_at]"

      assert_select "input[name=?]", "appointment[end_at]"
    end
  end
end
