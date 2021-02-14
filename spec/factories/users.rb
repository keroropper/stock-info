FactoryBot.define do
  factory :user do
    nickname { "tester" }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { password }
  end
end
