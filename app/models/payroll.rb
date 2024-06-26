class Payroll < ApplicationRecord
  belongs_to :user
  has_many :payroll_histories

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'



  def get_all_payrolls
    Payroll.all
  end

  def find_and_update_payroll(params)
    Payroll.find(params[:id])
    payroll = Payroll.update(params)
    payroll
  end

end