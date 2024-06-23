class CreateJobPositions < ActiveRecord::Migration[7.1]
  def change
    create_table :job_positions do |t|
      t.string :title,null: false
      t.text :description

      t.timestamps
    end
  end
end
