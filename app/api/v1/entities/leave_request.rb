
class V1::Entities::LeaveRequest < Grape::Entity
  expose :id,  if: {type: :full}
  expose :requestee_id
  expose :approver_id
  expose :leave_id
  expose :start_date
  expose :end_date
  expose :working_days_covered
  expose :status
end

