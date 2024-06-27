class RemoveColumnInLeaveRequests < ActiveRecord::Migration[7.1]
  def change
    remove_column :leave_requests, :approver_id
  end
end
