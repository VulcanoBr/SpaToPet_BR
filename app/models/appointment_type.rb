class AppointmentType < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_rich_text :description
  normalizes :name, with: -> (name) { name.downcase }

  validates :name, :user_id, :price, presence: true
end
