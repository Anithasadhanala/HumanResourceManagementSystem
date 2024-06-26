class CreateTableBankCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :table_bank_credentials do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.string :bank_name, null: false
      t.string :bank_branch, null: false
      t.string :bank_place, null: false
      t.string :account_number, null: false
      t.string :ifsc_code, null: false
      t.string :bank_branch_code, null: false
      t.string :account_type, null: false

      t.timestamps
    end
  end
end
