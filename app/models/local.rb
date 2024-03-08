class Local < ApplicationRecord
  has_one_attached :image
  belongs_to :city
  has_many :appointments
end
