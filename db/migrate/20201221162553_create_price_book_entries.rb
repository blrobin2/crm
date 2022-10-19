class CreatePriceBookEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :price_book_entries do |t|
      t.decimal :list_price, precision: 8, scale: 2, null: false
      t.boolean :is_active, null: false, default: true
      t.belongs_to :price_book, foreign_key: { to_table: :price_books }
      t.belongs_to :product, foreign_key: { to_table: :products }
      t.timestamps
    end

    add_index :price_book_entries, [:price_book_id, :product_id]
  end
end
