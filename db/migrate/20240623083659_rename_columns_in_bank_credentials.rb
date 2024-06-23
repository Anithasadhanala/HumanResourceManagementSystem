class RenameColumnsInBankCredentials < ActiveRecord::Migration[7.1]
  def change
    rename_column :bank_credentials, :encrypted_account_number, :account_number_ciphertext
    rename_column :bank_credentials, :encrypted_ifsc_code, :ifsc_code_ciphertext
    rename_column :bank_credentials, :encrypted_bank_branch_code, :bank_branch_code_ciphertext

    change_column :bank_credentials, :account_number_ciphertext, :text, null: false
    change_column :bank_credentials, :ifsc_code_ciphertext, :text, null: false
    change_column :bank_credentials, :bank_branch_code_ciphertext, :text, null: false

  end
end
