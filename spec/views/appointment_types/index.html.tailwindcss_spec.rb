require 'rails_helper'

RSpec.describe "appointment_types/index", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }

  before(:each) do
    assign(:appointment_types, [
      AppointmentType.create!(
        name: "Name",
        payment_required: true,
        user: user,
        price: 3,
        description: "Meu teste Amarelo"
      ),
      AppointmentType.create!(
        name: "Name",
        payment_required: true,
        user: user,
        price: 2,
        description: "Meu teste Azul"
      )
    ])
  end

  it "renders a list of appointment_types" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'

    assert_select cell_selector, text: Regexp.new("Payment Required:"), count: 2
    assert_select cell_selector, text: Regexp.new("Name:"), count: 2
    assert_select cell_selector, text: Regexp.new("User:"), count: 2
    assert_select cell_selector, text: Regexp.new("Price:"), count: 2
    assert_select cell_selector, text: Regexp.new("Description"), count: 2
  end
end
