require 'rails_helper'

RSpec.describe "appointment_types/new", type: :view do
  before(:each) do
    assign(:appointment_type, AppointmentType.new(
      payment_required: false,
      name: "MyString",
      user: nil,
      price: 1,
      description: nil
    ))
  end

  it "renders new appointment_type form" do
    render

    assert_select "form[action=?][method=?]", appointment_types_path, "post" do

      assert_select "input[name=?]", "appointment_type[payment_required]"

      assert_select "input[name=?]", "appointment_type[name]"

      assert_select "input[name=?]", "appointment_type[user_id]"

      assert_select "input[name=?]", "appointment_type[price]"

      assert_select "input[name=?]", "appointment_type[description]"
    end
  end
end
