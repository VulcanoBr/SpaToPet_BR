class Payment < ApplicationRecord
  has_one_attached :receipt
  belongs_to :user
  belongs_to :appointment
  enum billing_status: { pending: 0, approved: 1, unapproved: 2 }
end
