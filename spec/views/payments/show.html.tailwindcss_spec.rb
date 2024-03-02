require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    assign(:payment, Payment.create!(
      billing_status: 2,
      user: nil,
      appointment: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
