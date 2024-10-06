FactoryBot.define do
  factory :patient do
    full_name { "John Doe" } # Add this to fix the validation error
    sequence(:email) { |n| "patient#{n}@example.com" }
    password { "password123" }
    phone_number { "1234567890" }
    address { "123 Test Street" }
    date_of_birth { "1990-01-01" }
  end
end
