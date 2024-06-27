class CreateOpeningsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :openings_tables do |t|

      t.timestamps
    end
  end
end
