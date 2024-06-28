# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  include AuthoriseUser

  has_one :employee
  has_one :payroll
  has_many :addresses
  has_many :bank_credentials
  has_many :user_jwt_tokens
  has_many :leave_requests
  has_many :employee_supervisors
  has_many :allowance_and_deductions
  has_one :hike
  has_many :position_histories
  has_one :payroll
  has_many :employee_documents

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :bank_credentials, allow_destroy: true
  accepts_nested_attributes_for :employee_supervisors, allow_destroy: true
  accepts_nested_attributes_for :employee, allow_destroy: true
  accepts_nested_attributes_for :payroll, allow_destroy: true
  accepts_nested_attributes_for :employee_documents, allow_destroy: true

  after_create :create_associated_records

  attr_accessor :addresses_attributes
  attr_accessor :bank_credentials_attributes
  attr_accessor :employee_supervisors_attributes
  attr_accessor :employee_attributes
  attr_accessor :payroll_attributes
  attr_accessor :employee_documents_attributes

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :role, presence: true

  scope :active, -> { where(is_active: true) }
  scope :approved, -> { where(status: 'approved') }


  def create_associated_records
    transaction do
      create_associated_addresses if addresses_attributes.present?
      create_associated_bank_credentials if bank_credentials_attributes.present?
      create_associated_employee_supervisors if employee_supervisors_attributes.present?
      create_associated_employee if employee_attributes.present?
      create_associated_payroll if payroll_attributes.present?
      create_associated_employee_documents if employee_documents_attributes.present?
    rescue ActiveRecord::RecordInvalid => e
      raise ActiveRecord::Rollback, "Failed to create associated records: #{e.message}"
    end
  end

  def create_associated_addresses
    Address.create!(
        d_no: addresses_attributes[:d_no],
        landmark: addresses_attributes[:landmark],
        city: addresses_attributes[:city],
        zip_code: addresses_attributes[:zip_code],
        state: addresses_attributes[:state],
        country: addresses_attributes[:country],
        is_permanent: true,
        employee_id: id)
  end


  def create_associated_bank_credentials
    BankCredential.create!(
        bank_name: bank_credentials_attributes[:bank_name],
       bank_branch: bank_credentials_attributes[:bank_branch],
       account_number: bank_credentials_attributes[:account_number],
       ifsc_code: bank_credentials_attributes[:ifsc_code],
       bank_branch_code: bank_credentials_attributes[:bank_branch_code],
       account_type: bank_credentials_attributes[:account_type],
      employee_id: id)
  end


  def create_associated_employee_supervisors
      EmployeeSupervisor.create!(supervisor_id: employee_supervisors_attributes[:supervisor_id],
                                 employee_id: id,
                                 secondary_supervisor_id: employee_supervisors_attributes[:secondary_supervisor_id])
  end


  def create_associated_payroll
      Payroll.create!(base_payroll: payroll_attributes[:base_payroll], employee_id: id)
  end


  def create_associated_employee_documents
    employee_documents = []
    employee_documents_attributes.each do |employee_document|
      employee_document = employee_document.merge(user_id: id)
      employee_document = EmployeeDocument.new(employee_document)
      if employee_document.save
        employee_documents << employee_document
      else
        raise ActiveRecord::RecordInvalid
      end
    end
    employee_documents
  end



  def create_associated_employee
    Employee.create!(
      user_name: employee_attributes[:user_name],
      first_name: employee_attributes[:first_name],
      last_name: employee_attributes[:last_name],
      phone: employee_attributes[:phone],
      hired_at: employee_attributes[:hired_at],
      personal_email: employee_attributes[:personal_email],
      emergency_contact_phone: employee_attributes[:emergency_contact_phone],
      emergency_contact_name: employee_attributes[:emergency_contact_name],
      gender: employee_attributes[:gender],
      experience_in_months: employee_attributes[:experience_in_months],
      qualifications: employee_attributes[:qualifications],
      employee_type: employee_attributes[:employee_type],
      employment_type: employee_attributes[:employment_type],
      job_position_id: employee_attributes[:job_position_id],
      department_id: employee_attributes[:department_id],
      user_id: id)
  end


    def create_user(params)
        authorise_admin
        User.create!(
        role: params[:role],
        email: params[:email],
        password: params[:password],
        addresses_attributes: params[:addresses_attributes],
        employee_supervisors_attributes: params[:employee_supervisors_attributes],
        bank_credentials_attributes: params[:bank_credentials_attributes],
        employee_attributes: params[:employee_attributes],
        payroll_attributes: params[:payroll_attributes],
        employee_documents_attributes: params[:employee_documents_attributes],
        )
    end


  def get_leave_request(employee_id,leave_request_id)
    authorise_employee(employee_id)
    leave_request = LeaveRequest.find_by(requestee_id: employee_id,id: leave_request_id)
    leave_request
  end



  def get_all_leave_requests(employee_id)
    authorise_employee(employee_id)
    leave_requests = LeaveRequest.where(requestee_id: employee_id)
    leave_requests

  end

  def get_allowance_and_deduction(employee_id, compensation_id)
    employee = Employee.find_by(id: employee_id)
    authorise_user(employee.user_id)
      allowance_deduction = AllowanceAndDeduction.find_by(id: compensation_id, is_active: true, employee_id: employee_id)
      if allowance_deduction
        allowance_deduction
      else
        raise ActiveRecord::RecordNotFound
      end
  end

  def get_all_allowance_and_deductions(employee_id)
    authorise_user(employee.user_id)
    allowance_deductions = AllowanceAndDeduction.where( is_active:true, employee_id: employee_id)
    if allowance_deductions
      allowance_deductions
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def get_hike(user_id, hike_id)
     authorise_user(user_id)
      allowance_deduction = Hike.find_by(id: hike_id, is_active: true, employee_id: user.id)
      if allowance_deduction
        allowance_deduction
      else
        raise ActiveRecord::RecordNotFound
      end
  end


  def get_all_position_histories(employee_id)
    employee  = Employee.find(employee_id)
    authorise_user(employee.user_id)
    PositionHistory.where(employee_id: employee_id)
  end

  def get_position_history(employee_id, id)
    employee  = Employee.find(employee_id)
    authorise_user(employee.user_id)
    position_history = PositionHistory.find_by(employee_id: employee_id, id: id)
    if position_history
      position_history
    else
      raise ActiveRecord::RecordNotFound
    end
  end



  def get_leave_details(employee_id)
    employee = Employee.find(employee_id)
    authorise_user(employee.user_id)
    leave_requests = LeaveRequest.where(requestee_id: employee_id).approved

    leave_details = leave_requests.group_by(&:leave).map do |leave, requests|
      days_taken = requests.sum(&:working_days_covered)
      {
        leave_title: leave.title,
        days_taken: days_taken,
        days_remaining: leave.days_count - days_taken
      }
    end
    {

      total_days_taken: leave_details.sum { |details| details[:days_taken] },
      leave_details: leave_details
    }
  end




  def get_all_payroll_histories(employee_id)
    employee = Employee.find(employee_id)
    authorise_user(employee.user_id)
    payrolls = Payroll.where(employee_id: employee_id).pluck(:id)
    payrolls = PayrollHistory.where(payroll_id: payrolls)
    if payrolls
      payrolls
    else
      raise ActiveRecord::RecordNotFound end
    end


  def get_payroll_history(employee_id, id)
    employee = Employee.find(employee_id)
    authorise_user(employee.user_id)
    PayrollHistory.find(id)
  end


  def delete_employee(employee_id)
    user = User.find_by(id: employee_id, is_active: true)
    if user
      user.update(is_active: false)
      UserJwtToken.where(user_id: employee_id).update_all(is_active: false)
      {message: "Employee with id: #{employee_id}  is deleted!!!"}
    else
      raise ActiveRecord::RecordNotFound, {message: "This employee, is not Found"}
    end
  end



  def get_all_employee_documents(user)
    documents =  user.employee_documents
    if documents
      documents
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def find_employee_document_by_id(employee, id)
    employee.employee_documents.find(id)
  end


end

