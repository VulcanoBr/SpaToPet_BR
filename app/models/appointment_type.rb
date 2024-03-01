class AppointmentType < ApplicationRecord
  belongs_to :user
  has_rich_text :description
  normalizes :name, with: -> (name) { name.downcase }
end
