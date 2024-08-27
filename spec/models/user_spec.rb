require 'rails_helper'

RSpec.describe User, type: :model do
  # Testar a validação de presença de atributos
  describe 'validations' do
    it 'creates a valid user' do
      user = User.new(first_name: "John", last_name: "Doe", username: "johndoe",
                      phone: "(21)98897-5959", email: "john@example.com",
                      password: "123456", role: 0)
      expect(user).to be_valid
    end

    it 'is invalid without a first_name' do
      user = User.new(last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("Can't be blank")
    end

    it 'is invalid without an email' do
      user = User.new(first_name: 'John', last_name: 'Doe', username: 'user123', phone: '1234567890', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("Can't be blank")
    end

    # Validar formato de e-mail
    it 'is invalid with a wrong email format' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'wrongemail', username: 'user123', phone: '1234567890', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("Invalid")
    end

    # Validar unicidade do e-mail
    it 'is invalid with a duplicate email' do
      existing_user = User.create!(first_name: 'John', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'password')
      new_user = User.new(first_name: 'Jane', last_name: 'Smith', email: 'example@example.com', username: 'user456', phone: '0987654321', password: 'password123')
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include("has already been taken")
    end

    # Validar comprimento mínimo da senha
    it 'is invalid with a short password' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'example@example.com', username: 'user123', phone: '1234567890', password: 'pass')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("Is too short (minimum is 6 characters)")
    end
  end
end
