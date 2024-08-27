FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    username { "MyString" }
    phone { "MyString" }
    email { "vulcan@example.com" }
    password { "123456" }
    role { 2 }
  end
end
