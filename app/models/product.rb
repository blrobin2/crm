class Product < ApplicationRecord
  has_many :price_book_entries,
           dependent: :destroy
  has_many :price_books, through: :price_book_entries

  enumeration :quantity_unit_of_measure
  validates :quantity_unit_of_measure, presence: true
  validates :name, presence: true
end
