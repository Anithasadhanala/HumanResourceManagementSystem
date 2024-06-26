class DeleteColumnInBank < ActiveRecord::Migration[7.1]
  def change
    remove_column :bank_credentials, :bank_place
  end
end
