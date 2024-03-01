FactoryBot.define do
  factory :appointment do
    status { 1 }
    user { nil }
    appointment_type { nil }
    start_at { "2024-03-01 10:45:43" }
    end_at { "2024-03-01 10:45:43" }
  end
end
