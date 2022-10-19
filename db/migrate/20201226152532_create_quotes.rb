class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :contact, foreign_key: { to_table: :contacts }
      t.belongs_to :opportunity, null: true, foreign_key: { to_table: :opportunities }
      t.string :status, null: false
      t.date :expiration_date, null: false
      t.decimal :tax, precision: 8, scale: 2, null: false
      t.timestamps
    end

    create_table :quote_line_items do |t|
      t.belongs_to :product, foreign_key: { to_table: :products }
      t.belongs_to :quote, foreign_key: { to_table: :quotes }
      t.belongs_to :sales_price, foreign_key: { to_table: :price_book_entries }
      t.date :effective_date, null: false
      t.decimal :discount, precision: 8, scale: 2, null: false
      t.integer :quantity
    end

    add_index :quote_line_items, [:product_id, :quote_id]
  end
end
