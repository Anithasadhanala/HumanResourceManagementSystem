class LeaveRequest < ApplicationRecord
  belongs_to :leave
  belongs_to :requestee, class_name: 'User', foreign_key: 'requestee_id'

  validates :requestee_id, :leave_id, :start_date, :end_date, :working_days_covered, presence: true


  enum status: {
    pending: 'pending',
    rejected: 'rejected',
    approved: 'approved'
  }

  def status_is_valid_enum(status)
    self.class.statuses.key?(status.to_sym)
  end

  def create_leave_request(params)
    authorise_employee(params[:employee_id])
    params = params.merge(requestee_id: params[:employee_id])
    LeaveRequest.create!(params)
  end

  def count_prev_leaves_approved(requestee_id)
    approved_leave_requests = LeaveRequest.where(status: :approved, requestee_id: requestee_id)
    approved_leave_requests.sum(:working_days_covered)
  end


  def validate_leave(leave_request_instance)
    max_days_for_leave_type = Leave.find( leave_request_instance.leave_id)
    count_prev_leaves_approved(leave_request_instance)+leave_request_instance.working_days_covered <= max_days_for_leave_type.days_count
  end


  def find_and_update_leave_request(params)
    leave_request = LeaveRequest.find(params[:id])
    approver = EmployeeSupervisor.find(leave_request.requestee_id)
    supervisor_id = approver.supervisor_id
    secondary_supervisor_id = approver.secondary_supervisor_id
    current_user= Current.user.id
    puts(current_user, leave_request.requestee_id,"````````````````````````````````````````")
   if leave_request.requestee_id == current_user
     puts("????????????????????????????????????????????????????????????/")
      leave_request.update(params.except(:status))
   elsif supervisor_id == current_user || secondary_supervisor_id == current_user
     if params[:status]
        if !status_is_valid_enum(params[:status])
          ("not a valid status value that is requested to update")
        else
          if validate_leave(leave_request)
            params = params.merge(approver_id: current_user)
            leave_request.update( params)
            leave_request
          else
            ("Your limit is exceed, cannot take leaves!!!")
          end
        end
      else
        ("supervisor can't update the requested fields!!!")
      end
   else

         {error: "Unauthorized access - 402" }
       end
  end

end