require 'rails_helper'

RSpec.describe "locals/new", type: :view do
  before(:each) do
    assign(:local, Local.new(
      city: nil,
      address: "MyText"
    ))
  end

  it "renders new local form" do
    render

    assert_select "form[action=?][method=?]", locals_path, "post" do

      assert_select "input[name=?]", "local[city_id]"

      assert_select "textarea[name=?]", "local[address]"
    end
  end
end
