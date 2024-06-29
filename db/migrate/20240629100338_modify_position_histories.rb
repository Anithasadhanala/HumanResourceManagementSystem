class ModifyPositionHistories < ActiveRecord::Migration[6.0]
  def change
    change_table :position_histories do |t|
      t.references :job_position, foreign_key: true
      t.date :joined_at
      t.remove :from_role_id, :to_role_id, :switch_reason
    end
  end
end
