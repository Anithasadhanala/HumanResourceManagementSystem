class DropTableBankCredentials < ActiveRecord::Migration[7.1]
  def change
    drop_table :bank_credentials
  end
end
