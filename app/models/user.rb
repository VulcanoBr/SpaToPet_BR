class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :appointment_types
  has_many :pets, dependent: :destroy
  has_many :appointments, foreign_key: :client_id, dependent: :destroy
  validates :first_name, :last_name, :email, :username, :phone, presence: { message: :blank }
  validates :password, length: { minimum: 6 }, presence: { message: :blank }, on: :create
  validates :email, uniqueness: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }

  validates :username, uniqueness: true,
    length: { in: 3..15 },
    format: {
      with: /\A[a-z0-9A-Z]+\z/,
      message: :invalid
    }
  validates :phone, uniqueness: true

  normalizes :username, :first_name, :last_name, with: ->(value) { value.downcase }
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end

  enum role: [:client , :stylist, :admin]

  ROLES = %w[client stylist admin]

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end
end
