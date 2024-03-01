require 'rails_helper'

RSpec.describe "pets/index", type: :view do
  before(:each) do
    assign(:pets, [
      Pet.create!(
        name: "Name",
        breed: "Breed",
        kind: 2,
        user: nil
      ),
      Pet.create!(
        name: "Name",
        breed: "Breed",
        kind: 2,
        user: nil
      )
    ])
  end

  it "renders a list of pets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Breed".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
