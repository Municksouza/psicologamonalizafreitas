FactoryBot.define do
  factory :testimonial do
    content { "Wonderful session!" }
    association :patient, factory: :patient
    association :psychologist, factory: :psychologist
  end
end
