require 'rails_helper'

RSpec.describe "locals/show", type: :view do
  before(:each) do
    assign(:local, Local.create!(
      city: nil,
      address: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
