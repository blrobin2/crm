class CreateTerritoryHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :territory_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :territory_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "territory_anc_desc_idx"

    add_index :territory_hierarchies, [:descendant_id],
      name: "territory_desc_idx"
  end
end
