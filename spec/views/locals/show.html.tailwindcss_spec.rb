require 'rails_helper'

RSpec.describe "locals/show", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456", role: 2) }
  let(:city) { City.create!(name: "Cidade dea Luz") }
  let(:local) { Local.create!(city: city, address: "Endereço de terste") }
  
  let(:current_user) { user }

  before(:each) do
    @appointment_types = FactoryBot.create_list(:appointment_type, 3, user: user) # Cria uma lista de appointment_types
    #allow(view).to receive(:current_user).and_return(user)
    @current_user = user
   
    assign(:local, Local.create!(
      city: city,
      address: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/City:/)
    expect(rendered).to match(/Address:/)
    expect(rendered).to match(/MyText/)
  end
end
