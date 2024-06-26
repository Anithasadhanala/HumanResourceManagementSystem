class ChangeTableName < ActiveRecord::Migration[7.1]
  def change
    # change table name
    rename_table :table_bank_credentials, :bank_credentials
  end
end
