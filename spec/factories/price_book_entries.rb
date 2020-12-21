FactoryBot.define do
  factory :price_book_entry do
    list_price { Faker::Number.decimal(l_digits: 2) }
    is_active { true }
    price_book
    product
  end
end
