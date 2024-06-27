class PositionHistory < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'


  def find_and_update_position_history(params)
    if params[:to_role_id]
      Employee.new.update_employee_job_position(params)
    end
    position_history = PositionHistory.find_by(params[:id])
    position_history.update!(params)
    position_history
  end

end