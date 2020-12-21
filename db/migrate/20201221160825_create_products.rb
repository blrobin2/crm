class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :is_active, null: false, default: true
      t.string :code, null: false
      t.text :description, null: false, default: ''
      t.string :quantity_unit_of_measure, null: false
      t.timestamps
    end
  end
end
