class Pet < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :appointments
  has_rich_text :important_data
  validates :name, :breed, :kind, presence: { message: :blank }
  normalizes :name, :breed, with: ->(value) { value.downcase }
  enum kind: { dog: 0, cat: 1, bird: 2, fish: 3, other: 4 }
end
