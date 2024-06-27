class RenameATableOpenings < ActiveRecord::Migration[7.1]
  def change
    rename_table :openings_tables, :openings
  end
end
