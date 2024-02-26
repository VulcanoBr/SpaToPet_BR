require 'rails_helper'

RSpec.describe "appointment_types/edit", type: :view do
  let(:appointment_type) {
    AppointmentType.create!(
      payment_required: false,
      name: "MyString",
      user: nil,
      price: 1,
      description: nil
    )
  }

  before(:each) do
    assign(:appointment_type, appointment_type)
  end

  it "renders the edit appointment_type form" do
    render

    assert_select "form[action=?][method=?]", appointment_type_path(appointment_type), "post" do

      assert_select "input[name=?]", "appointment_type[payment_required]"

      assert_select "input[name=?]", "appointment_type[name]"

      assert_select "input[name=?]", "appointment_type[user_id]"

      assert_select "input[name=?]", "appointment_type[price]"

      assert_select "input[name=?]", "appointment_type[description]"
    end
  end
end
