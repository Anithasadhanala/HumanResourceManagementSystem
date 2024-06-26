# app/models/employee.rb
class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :job_position
  belongs_to :department
  has_many :addresses
  has_many :job_histories

  validates :user_name,:first_name,:last_name, :phone, :hired_at, :personal_email, :emergency_contact_phone, :emergency_contact_name,
            :gender, :department_id,:job_position_id,:experience_in_months, :qualifications, :employee_type, :employment_type, presence: true

  scope :active, -> { where(is_active: true) }


  def find_by_id(employee_id)
    Employee.find(employee_id)
  end


  def find_and_update_employee(params)
    find_by_id(params[:id])
    employee = Employee.update!(params.except(:job_position_id))
    employee
  end


  def update_employee_job_position(params)
    employee = Employee.find(params[:employee_id])
    if !employee.job_position_id == params[:to_role_id]
    employee.update!(job_position_id: params[:to_role_id])
    employee
    else
      raise RuntimeError, {message: "You cannot switch an employee position to itself!!!"}
    end
  end

  def get_job_history(employee_id,job_history_id)
    employee = Employee.find(employee_id)
    if employee
      employee.job_histories.find( job_history_id)
    end
  end

  def get_all_job_histories(employee_id)
    employee = Employee.find(employee_id)
    if employee
    employee.job_histories
    end
  end


  def get_all_bank_credentials(employee_id)
    employee = Employee.find(employee_id)
    if employee
      employee.bank_credentials.active
    end
  end


  def get_bank_credential(employee_id, job_history_id)
    employee = Employee.find(employee_id)
    if employee
      bank_credential = employee.bank_credentials.active.find_by(id: job_history_id)
      if bank_credential
        bank_credential
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end








end
