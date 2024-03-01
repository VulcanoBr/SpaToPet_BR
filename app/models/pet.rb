class Pet < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_rich_text :important_data
  validates :name, :breed, :kind, presence: { message: :blank }
  enum kind: { dog: 0, cat: 1, bird: 2, fish: 3, other: 4 }
end
