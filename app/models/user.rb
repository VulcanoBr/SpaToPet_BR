class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :username, :phone, :email, presence: true
  validates :username, :phone, :email, uniqueness: true
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: :invalid
  }
  validates :username,
    length: { in: 3..15 },
    format: {
      with: /\A[a-z0-9A-Z]+\z/,
      message: :invalid
    }
  validates :password, length: { minimum: 6 }
  
  before_save :downcase_attributes

  enum role: [:client, :stylist, :admin]

  ROLES = %w[client stylist admin]

  ROLES.each do |role|
    define_method("#{role}?") { self.role == role }
  end

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email.downcase
    self.first_name = first_name.downcase
    self.last_name = last_name.downcase
  end
end
