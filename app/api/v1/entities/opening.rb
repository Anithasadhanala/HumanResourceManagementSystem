class V1::Entities::Opening < Grape::Entity
  expose :id,  if: {type: :full}
  expose :job_position_id
  expose :required_qualifications
  expose :max_salary
  expose :min_salary
  expose :openings_count
  expose :occupancy_count
  expose :created_by_id
  expose :employment_type
  end