class Payment < ApplicationRecord
  has_one_attached :receipt
  belongs_to :user
  belongs_to :appointment
  enum billing_status: { pending: 0, onapproval: 3, approved: 6, unapproved: 9 }

  validates :user_id,  presence: true

  before_save :set_billing_status_on_approval, if: -> { receipt.present? }
  after_save :send_email, if: -> { self.billing_status == :onapproval }

  private

  def set_billing_status_on_approval
    return if self.billing_status == "approved" || self.billing_status == "unapproved"

    self.billing_status = :onapproval
  end

  def send_email
    PaymentMailer.send_payment_receipt(self.appointment_id).deliver_now
  end
end
