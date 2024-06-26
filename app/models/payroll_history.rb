class PayrollHistory < ApplicationRecord
  belongs_to :payroll


  def payroll_calculation(employee_id)
    base_payroll = Payroll.where(employee_id: employee_id).pluck(:base_payroll).first || 0
    allowances = AllowanceAndDeduction.where(employee_id: employee_id, is_deduction: false, is_active: true).sum(:amount) || 0
    deductions = AllowanceAndDeduction.where(employee_id: employee_id, is_deduction: true, is_active: true).sum(:amount) || 0
    adjusted_payroll = base_payroll + allowances - deductions
    hike_percentage = Hike.where(employee_id: employee_id, is_active: true).pluck(:percentage_value).first
    if hike_percentage
      adjusted_payroll += (adjusted_payroll * hike_percentage / 100)
    end
    adjusted_payroll
  end

  def create_payroll_history(params)

    final_payroll = payroll_calculation(params[:employee_id])
    payroll_id = Payroll.where(employee_id: params[:employee_id]).pluck(:id).first
    puts(payroll_id,"))))))))))))))))))))))))))))))))))))))))))))))))))")
    User.find(params[:employee_id])
    PayrollHistory.create!(
      payroll_id: payroll_id,
      bank_credential_id: params[:bank_credential_id],
      payroll_predicted: final_payroll
    )
  end


end
