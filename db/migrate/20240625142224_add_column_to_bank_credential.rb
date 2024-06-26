class AddColumnToBankCredential < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_credentials, :is_active, :boolean, default: true
  end
end
