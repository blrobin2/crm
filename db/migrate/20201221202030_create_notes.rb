class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :content, null: false
      t.references :notable, null: false, polymorphic: true
      t.belongs_to :user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
