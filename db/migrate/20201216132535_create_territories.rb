class CreateTerritories < ActiveRecord::Migration[6.0]
  def change
    create_table :territories do |t|
      t.string :name, null: false, unique: true
      t.belongs_to :advisor, null: true, foreign_key: { to_table: :users }
      t.belongs_to :sales, null: true, foreign_key: { to_table: :users }
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
