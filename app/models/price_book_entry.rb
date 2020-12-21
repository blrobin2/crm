class PriceBookEntry < ApplicationRecord
  belongs_to :product
  belongs_to :price_book

  validates :list_price, presence: true, numericality: { greater_than: BigDecimal(0) }
end
