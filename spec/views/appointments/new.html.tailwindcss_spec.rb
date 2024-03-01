require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  before(:each) do
    assign(:appointment, Appointment.new(
      status: 1,
      user: nil,
      appointment_type: nil
    ))
  end

  it "renders new appointment form" do
    render

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "input[name=?]", "appointment[status]"

      assert_select "input[name=?]", "appointment[user_id]"

      assert_select "input[name=?]", "appointment[appointment_type_id]"
    end
  end
end
