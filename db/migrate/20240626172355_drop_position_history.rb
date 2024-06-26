class DropPositionHistory < ActiveRecord::Migration[7.1]
  def change
    drop_table :position_histories
  end
end
