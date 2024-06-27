class AddApproverIdToLeaveRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :leave_requests, :approver_id, :integer
  end
end
