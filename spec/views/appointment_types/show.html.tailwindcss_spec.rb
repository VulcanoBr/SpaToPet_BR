require 'rails_helper'

RSpec.describe "appointment_types/show", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  before(:each) do
    assign(:appointment_type, AppointmentType.create!(
      payment_required: true,
      name: "Name",
      user: user,
      price: 2,
      description: "Meu teste Azul"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/true/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Meu teste Azul/)
  end
end
