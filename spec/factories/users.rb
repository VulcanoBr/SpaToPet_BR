FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    username { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
