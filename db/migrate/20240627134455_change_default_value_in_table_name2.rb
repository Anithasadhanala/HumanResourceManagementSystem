class ChangeDefaultValueInTableName2 < ActiveRecord::Migration[7.1]
  def change
    change_column :openings, :employment_type, :string

  end
end
