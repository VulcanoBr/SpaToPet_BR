FactoryBot.define do
  factory :payment do
    billing_status { 0 }
    user 
    appointment
  end
end
