# app/models/employee.rb
class Employee < ApplicationRecord
  include AuthoriseUser

  belongs_to :user
  belongs_to :job_position
  belongs_to :department
  has_many :addresses
  has_many :job_histories

  validates :user_name,:first_name,:last_name, :phone, :hired_at, :personal_email, :emergency_contact_phone, :emergency_contact_name,
            :gender, :department_id,:job_position_id,:experience_in_months, :qualifications, :employee_type, :employment_type, presence: true
  scope :active, -> { where(is_active: true) }


  def find_by_id(employee_id)
    employee = Employee.find_by(id: employee_id)
      authorise_user(employee.user_id)
      Employee.find(employee_id)
  end


  def find_and_update_employee(params)
    employee = Employee.find(params[:id])
    authorise_user(employee.user_id)
    employee_instance = find_by_id(employee.id)
    employee_instance.update(params.except(:job_position_id))
    employee_instance
  end


  def update_employee_job_position(params)
    employee = Employee.find_by(user_id: params[:employee_id])
    if !(employee.job_position_id.to_i == params[:job_position_id].to_i)
    employee.update(job_position_id: params[:job_position_id])
    employee
    else
      raise RuntimeError, {message: "You cannot switch an employee position to itself!!!"}
    end
  end


  def get_job_history(employee_id,job_history_id)
    employee = Employee.find(employee_id)
    authorise_user(employee.user_id)
    employee = Employee.find(employee_id)
    if employee
      employee.job_histories.find( job_history_id)
    end
  end


  def get_all_job_histories(employee_id)
    employee = Employee.find(employee_id)
    authorise_user(employee.user_id)
    employee = Employee.find(employee_id)
    if employee
    employee.job_histories
    end
  end


  def get_all_bank_credentials(employee_id)
    if employee_id.present?
      authorise_user(employee_id)
    else
      employee_id = Current.user.id
    end
    BankCredential.active.where(employee_id:employee_id)
  end


  def get_bank_credential(id,employee_id)
    if employee_id.present?
      authorise_user(employee_id)
    end
    bank_credential = BankCredential.active.find_by(id: id)
    if bank_credential
      bank_credential
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
