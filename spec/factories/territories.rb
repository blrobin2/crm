require 'faker'

FactoryBot.define do
  factory :territory do
    name { Faker::String.random }
    advisor
    sales
  end
end
