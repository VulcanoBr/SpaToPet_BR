FactoryBot.define do
  factory :appointment_type do
    name { "MyString" }
    payment_required { false }
    user
    price { 1 }
    color { "Azul" }
  end
end
