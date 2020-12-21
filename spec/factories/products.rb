FactoryBot.define do
  factory :product do
    name { Faker::Device.model_name }
    code { Faker::Device.serial }
    description { 'Some product' }
    is_active { true }
    quantity_unit_of_measure { QuantityUnitOfMeasure.seat }
  end
end
