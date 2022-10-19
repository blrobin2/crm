class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.date :activated_date
      t.belongs_to :company_authorized_by, foreign_key: { to_table: :users }
      t.date :company_authorized_date
      t.belongs_to :customer_authorized_by, foreign_key: { to_table: :contacts }
      t.date :customer_authorized_date
      t.belongs_to :opportunity, null: true, foreign_key: { to_table: :opportunities }
      t.belongs_to :quote, null: true, foreign_key: { to_table: :quotes }
      t.belongs_to :contract, foreign_key: { to_table: :contracts }
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :order_type, null: false
      t.string :status, null: false
      t.timestamps
    end

    create_table :order_products do |t|
      t.belongs_to :order, foreign_key: { to_table: :orders }
      t.belongs_to :product, foreign_key: { to_table: :products }
      t.belongs_to :quote_line_item, null: true, foreign_key: { to_table: :quote_line_items }
      t.date :start_date
      t.date :end_date, null: false
      t.integer :quantity
      t.decimal :unit_price, precision: 8, scale: 2, null: false
    end

    add_index :order_products, [:order_id, :product_id]
  end
end
