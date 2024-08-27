require 'rails_helper'

RSpec.describe "pets/new", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  before(:each) do
    assign(:pet, Pet.new(
      name: "MyString",
      breed: "MyString",
      kind: 1,
      user: user,
      important_data: "Teste de funcionamento"
    ))
  end

  it "renders new pet form" do
    render

    assert_select "form[action=?][method=?]", pets_path, "post" do

      assert_select "input[name=?]", "pet[name]"

      assert_select "input[name=?]", "pet[breed]"

      assert_select "select[name=?]", "pet[kind]"

      assert_select "input[name=?]", "pet[important_data]"
    end
  end
end
