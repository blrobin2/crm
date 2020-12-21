class CreatePriceBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :price_books do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ''
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
