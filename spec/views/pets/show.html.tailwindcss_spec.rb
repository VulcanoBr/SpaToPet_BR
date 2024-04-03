require 'rails_helper'

RSpec.describe "pets/show", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  before(:each) do
    
    assign(:pet, Pet.create!(
      name: "Name",
      breed: "Breed",
      kind: 2,
      user: user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Breed/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
