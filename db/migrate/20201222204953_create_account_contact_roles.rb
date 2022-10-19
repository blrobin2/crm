class CreateAccountContactRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :account_contact_roles do |t|
      t.belongs_to :contact, foreign_key: { to_table: :contacts }
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.string :role, null: false
      t.boolean :primary, null: false, default: false
      t.timestamps
    end

    add_index :account_contact_roles, [:contact_id, :account_id]
  end
end
