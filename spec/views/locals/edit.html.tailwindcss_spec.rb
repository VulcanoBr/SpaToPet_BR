require 'rails_helper'

RSpec.describe "locals/edit", type: :view do
  let(:city) {City.create!(name: "Cidade do Sol")}
  let(:local) {
    Local.create!(
      city: city,
      address: "MyText"
    )
  }

  before(:each) do
    assign(:local, local)
  end

  it "renders the edit local form" do
    render

    assert_select "form[action=?][method=?]", local_path(local), "post" do

      assert_select "select[name=?]", "local[city_id]"

      assert_select "textarea[name=?]", "local[address]"
    end
  end
end
