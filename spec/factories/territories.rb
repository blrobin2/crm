require 'faker'

FactoryBot.define do
  factory :territory do
    name { Faker::String.random.delete("\u0000") }

    factory :territory_with_assignments do
      advisor
      sales
    end
  end
end
