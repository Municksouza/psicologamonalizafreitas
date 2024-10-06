FactoryBot.define do
  factory :psychologist do
    full_name { "Dr. Sarah Smith" } # Add this to fix the validation error
    sequence(:email) { |n| "psychologist#{n}@example.com" }
    password { "password123" }
    phone_number { "0987654321" }
  end
end
