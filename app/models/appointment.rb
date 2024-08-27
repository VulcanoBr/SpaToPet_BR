class Appointment < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, associated_against: {
    client: [:first_name, :last_name],
    pet: [:name],
  }, using: {
    tsearch: { prefix: true }
  }

  belongs_to :client, class_name: "User"
  belongs_to :appointment_type
  belongs_to :pet
  belongs_to :local
  has_many :payments, dependent: :destroy
  accepts_nested_attributes_for :payments, allow_destroy: true, reject_if: :all_blank
  has_rich_text :notes

  validates :start_at, :end_at, presence: true
  validates :start_at, :end_at, comparison: { greater_than_or_equal_to: -> { Date.today } }
  validates :end_at, comparison: { greater_than_or_equal_to: :start_at }


  enum status: { scheduled: 0, processing: 1, finished: 2 }

  before_create :create_appointment_code

  scope :with_payment_onapproval, -> { joins(:payments).where(payments: { billing_status: 'onapproval' }) }

  pg_search_scope :search_by_code, against: :appointment_code

  ORDER_BY = {
    newest: "created_at DESC",
    lastest: "created_at ASC"
  }

  private

  def create_appointment_code
    self.appointment_code = DateTime.now.strftime("%Y%m%d%H%M%S") + rand(0..9).to_s
  end
end
