FactoryBot.define do
  factory :pet do
    name { "MyString" }
    breed { "MyString" }
    kind { 1 }
    user
    important_data { "Meu Teste "}
  end
end
