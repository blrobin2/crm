class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :territory, foreign_key: { to_table: :territories }
      t.string :name, null: false
      t.belongs_to :parent_account
      t.timestamps
    end
  end
end
