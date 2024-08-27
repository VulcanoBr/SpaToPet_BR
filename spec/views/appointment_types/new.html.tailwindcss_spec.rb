require 'rails_helper'

RSpec.describe "appointment_types/new", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role:2) }
  
  before(:each) do
    assign(:appointment_type, AppointmentType.new(
      payment_required: true,
      name: "MyString",
      user: user,
      price: 1,
      description: "Meu teste"
    ))
  end

  it "renders new appointment_type form" do
    
    render
    

    assert_select "form[action=?][method=?]", appointment_types_path, "post" do

      assert_select "input[name=?]", "appointment_type[payment_required]"

      assert_select "input[name=?]", "appointment_type[name]"

      assert_select "input[name=?]", "appointment_type[price]"

      assert_select "input[name=?]", "appointment_type[description]"
    end
  end
end
