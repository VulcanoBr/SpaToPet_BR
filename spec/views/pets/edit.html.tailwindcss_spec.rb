require 'rails_helper'

RSpec.describe "pets/edit", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  let(:pet) {
    Pet.create!(
      name: "MyString",
      breed: "MyString",
      kind: 1,
      user: user,
      important_data: "Teste de funcionamento"
    )
  }

  before(:each) do
    assign(:pet, pet)
  end

  it "renders the edit pet form" do
    render

    assert_select "form[action=?][method=?]", pet_path(pet), "post" do

      assert_select "input[name=?]", "pet[name]"

      assert_select "input[name=?]", "pet[breed]"

      assert_select "select[name=?]", "pet[kind]"

      assert_select "input[name=?]", "pet[important_data]"
    end
  end
end
