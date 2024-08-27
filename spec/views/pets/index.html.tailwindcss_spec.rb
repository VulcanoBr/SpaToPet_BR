require 'rails_helper'

RSpec.describe "pets/index", type: :view do
  let(:user) { User.create!(first_name: "John Doe", last_name: "Vulcan", username: "Vulcano",
                  phone: "(21)98897-5959", email: "john@example.com", password: "123456") }
  before(:each) do
    assign(:pets, [
      Pet.create!(
        name: "Name",
        breed: "Breed",
        kind: 2,
        user: user,
        important_data: "Teste de Funcionamento"
      ),
      Pet.create!(
        name: "Name",
        breed: "Breed",
        kind: 2,
        user: user,
        important_data: "Teste de Funcionamento"
      )
    ])
  end

  it "renders a list of pets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name:".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Breed".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Kind:".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("User:".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Important Data:".to_s), count: 2
  end
end
