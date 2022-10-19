FactoryBot.define do
  factory :note do
    content { Faker::Lorem.paragraphs }
    user
    association :notable, factory: :contact
  end
end
