class CreateOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :opportunities do |t|
      t.string :name, null: false
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :owner, foreign_key: { to_table: :users }
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.date :close_date, null: false
      t.string :forecast_category, null: false
      t.string :stage, null: false
      t.string :lead_source, null: false
      t.boolean :existing_business, null: false, default: false
      t.timestamps
    end
  end
end
