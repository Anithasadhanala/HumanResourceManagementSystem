class RenameOldTableNameToNewTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :positionhistories, :job_histories
  end
end
