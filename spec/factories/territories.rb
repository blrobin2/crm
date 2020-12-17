require 'faker'

FactoryBot.define do
  factory :territory do
    name { Faker::String.random.delete("\u0000") }
    advisor
    sales
  end
end
