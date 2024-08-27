FactoryBot.define do
  factory :appointment do
    appointment_code { DateTime.now.strftime("%Y%m%d%H%M%S") + rand(0..9).to_s }
    status { 0 }
    appointment_type
    local
    pet
    client { User }
    start_at { "2024-03-01 10:45:43" }
    end_at { "2024-03-01 10:45:43" }
  end
end
