class PriceBook < ApplicationRecord
  has_many :price_book_entries,
           dependent: :destroy
  has_many :products, through: :price_book_entries

  validates :name, presence: true
end
