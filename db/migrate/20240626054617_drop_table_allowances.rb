class DropTableAllowances < ActiveRecord::Migration[7.1]
  def change
    drop_table :allowances
  end
end
