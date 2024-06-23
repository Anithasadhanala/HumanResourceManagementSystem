class RenameColumnsInBankCredentials3 < ActiveRecord::Migration[7.1]
  def change
    remove_column :bank_credentials, :account_number_ciphertext, :string
    remove_column :bank_credentials, :ifsc_code_ciphertext, :string
    remove_column :bank_credentials, :bank_branch_code_ciphertext, :string
  end
end
