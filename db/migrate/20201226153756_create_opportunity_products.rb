class CreateOpportunityProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :opportunity_products do |t|
      t.belongs_to :opportunity, foreign_key: { to: :opportunities }
      t.belongs_to :product, foreign_key: { to: :product }
      t.integer :quantity
      t.timestamps
    end

    add_index :opportunity_products, [:opportunity_id, :product_id]
  end
end
