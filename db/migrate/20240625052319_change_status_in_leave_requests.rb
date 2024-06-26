class ChangeStatusInLeaveRequests < ActiveRecord::Migration[6.1]
  def up
    change_column :leave_requests, :status, :string, null: false, default: 'pending'
  end

  def down
    change_column :leave_requests, :status, :string, null: false
  end
end
