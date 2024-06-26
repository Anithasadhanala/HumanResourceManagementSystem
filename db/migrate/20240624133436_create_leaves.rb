class CreateLeaves < ActiveRecord::Migration[7.1]
  def change
    create_table :leaves do |t|
      t.string :title, null: false
      t.integer :days_count, null: false
      t.text :description

      t.timestamps
    end
  end
end
