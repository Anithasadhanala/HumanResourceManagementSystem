class RenameColumnsInBankCredentials2 < ActiveRecord::Migration[7.1]
  def change
    rename_column :bank_credentials, :account_number_ciphertext, :account_number
    rename_column :bank_credentials,  :ifsc_code_ciphertext, :ifsc_code
    rename_column :bank_credentials,  :bank_branch_code_ciphertext,  :bank_branch_code

    change_column :bank_credentials, :account_number_ciphertext, :string, null: false
    change_column :bank_credentials, :ifsc_code_ciphertext, :string, null: false
    change_column :bank_credentials, :bank_branch_code_ciphertext, :string, null: false

  end
end
