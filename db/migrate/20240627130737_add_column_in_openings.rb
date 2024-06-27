class AddColumnInOpenings < ActiveRecord::Migration[7.1]
  def change
    add_column :openings_tables, :is_active, :boolean, default: true
  end
end
