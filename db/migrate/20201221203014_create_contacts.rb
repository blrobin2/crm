class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :preferred_name, null: false, default: ''
      t.string :primary_phone, null: true
      t.string :secondary_phone, null: true
      t.string :email, null: false
      t.timestamps
    end

    add_index :contacts, :email, unique: true
  end
end
