class AddIsActiveToJobPositions < ActiveRecord::Migration[7.1]
  def change
    add_column :job_positions, :is_active, :boolean, default: true, null: false
  end
end
