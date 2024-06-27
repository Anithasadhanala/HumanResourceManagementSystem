class ChangeDefaultValueInTableName < ActiveRecord::Migration[7.1]
  def change
    change_column_default :openings, :occupancy_count, from: nil, to: 0
  end
end
