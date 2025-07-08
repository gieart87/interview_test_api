# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    phone { "123-456-7890" }
  end
end
