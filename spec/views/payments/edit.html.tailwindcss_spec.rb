require 'rails_helper'

RSpec.describe "payments/edit", type: :view do
  let(:payment) {
    Payment.create!(
      billing_status: 1,
      user: nil,
      appointment: nil
    )
  }

  before(:each) do
    assign(:payment, payment)
  end

  it "renders the edit payment form" do
    render

    assert_select "form[action=?][method=?]", payment_path(payment), "post" do

      assert_select "input[name=?]", "payment[billing_status]"

      assert_select "input[name=?]", "payment[user_id]"

      assert_select "input[name=?]", "payment[appointment_id]"
    end
  end
end
