class JobHistory < ApplicationRecord
  belongs_to :employee
  belongs_to :from_role, class_name: 'JobPosition', foreign_key: 'from_role_id'
  belongs_to :to_role, class_name: 'JobPosition', foreign_key: 'to_role_id'

  validates :employee_id,:from_role_id, :to_role_id,:switched_at,:switch_reason,:switch_type,presence: true

  def create_job_history(params)
    JobHistory.create!(params)
  end

  def find_and_update_job_history(params)
    job_history = JobHistory.find_by_id(params[:employee_id],params[:id])
    if job_history
      job_history.update(params)
      job_history
    end
  end

end