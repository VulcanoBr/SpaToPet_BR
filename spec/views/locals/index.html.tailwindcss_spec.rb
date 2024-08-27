require 'rails_helper'

RSpec.describe "locals/index", type: :view do
  let(:city) {City.create!(name: "Cidade do Sol")}
  let(:city2) {City.create!(name: "Cidade doa Luz")}

  before(:each) do
    assign(:locals, [
      Local.create!(
        city: city,
        address: "MyText"
      ),
      Local.create!(
        city: city2,
        address: "MyText"
      )
    ])
  end

  it "renders a list of locals" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    expect(rendered).to match(/City:/)
    expect(rendered).to match(/Address:/)
  end
end
