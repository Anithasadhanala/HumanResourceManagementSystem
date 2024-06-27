class AllowanceAndDeduction < ApplicationRecord

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'
  validates :compensation_type, presence: true
  scope :active, -> { where(is_active: true) }

  ALLOWANCES = {
    housing_allowance: 1000,
    travel_allowance: 800,
    food_allowance: 600,
    education_allowance: 1200,
    medical_allowance: 900
  }.freeze

  DEDUCTIONS = {
    tax: 100,
    pension: 200,
    insurance: 300,
    loan_repayment: 400,
    union_dues: 500
  }.freeze

  def valid_compensation_type(type, is_deduction)
    if is_deduction
      DEDUCTIONS.key?(type.to_sym)
    else
      ALLOWANCES.key?(type.to_sym)
    end
  end

def create_allowance_and_deduction(params)
  employee_present = AllowanceAndDeduction.find_by(employee_id: params[:employee_id], compensation_type: params[:compensation_type], is_active: true, is_deduction: params[:is_deduction])
  if employee_present
    raise RuntimeError, message: "You cannot add this Type #{params[:compensation_type]}, this is already active for employee with id:  #{params[:employee_id]}"
  else
    if valid_compensation_type(params[:compensation_type], params[:is_deduction])
      AllowanceAndDeduction.create!(params)
    else
      raise RuntimeError, message: "compensation_type is not valid!!"
    end
  end
end


  def find_and_update_allowance_and_deduction(params)
    allowance_deduction = AllowanceAndDeduction.find_by(employee_id: params[:employee_id],id: params[:id])
    if allowance_deduction
      allowance_deduction.update!(params.except(:is_active))
      allowance_deduction
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def find_and_destroy_employee_allowance_and_deduction(employee_id, id)
    allowance_deduction = AllowanceAndDeduction.find_by(employee_id: employee_id,id: id)
    if allowance_deduction
      allowance_deduction.update(is_active: false)
      ("allowance deduction column deleted with id: #{id}")
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
