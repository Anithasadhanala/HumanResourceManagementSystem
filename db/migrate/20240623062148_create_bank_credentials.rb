class CreateBankCredentials < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_credentials do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :bank_name, null: false
      t.string :bank_branch_place, null: false
      t.string :encrypted_account_number, null: false
      t.string :encrypted_ifsc_code, null: false
      t.string :encrypted_bank_branch_code, null: false
      t.string :account_type, null: false
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
