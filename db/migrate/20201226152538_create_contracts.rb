class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.belongs_to :account, foreign_key: { to_table: :accounts }
      t.belongs_to :company_signed_by, foreign_key: { to_table: :users }
      t.date :company_signed_date
      t.belongs_to :customer_signed_by, foreign_key: { to_table: :contacts }
      t.date :customer_signed_date
      t.date :activated_date
      t.date :start_date
      t.date :end_date
      t.string :status
      t.timestamps
    end

    add_reference :opportunities, :contract, index: true
    add_foreign_key :opportunities, :contracts
  end
end
