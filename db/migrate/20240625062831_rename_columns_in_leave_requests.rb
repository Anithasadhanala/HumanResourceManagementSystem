class RenameColumnsInLeaveRequests < ActiveRecord::Migration[7.1]
  def change
    rename_column :leave_requests, :employee_id, :requestee_id
    rename_column :leave_requests, :approval_id, :approver_id
  end
end
