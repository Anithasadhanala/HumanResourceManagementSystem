# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :employees

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :role, presence: true

  accepts_nested_attributes_for :employees


  def create_user(employee_params)
    valid_params = user_params(employee_params)

    first_name = valid_params[:employees_attributes][:first_name].split(' ').first.downcase
    custom_email = "#{first_name}.a@auzmor.com"
    password = "#{first_name}.123"
    puts(employee_params,'++++++++++++++++++++++++++++++++++++++++++++')

    # Create User and Employee records
    user = User.new(
      email: custom_email,
      password: password,
      role: valid_params[:role]
    )

    if user.save
      puts("====================================")
    else
      puts("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
    end

  end

  def user_params(params)
    params = ActionController::Parameters.new(params) unless params.is_a?(ActionController::Parameters)

    user_params = params.permit(:role)

    # Extract employee attributes and validate
    if params[:employees_attributes].present?
      employee_params = params.require(:employees_attributes).permit(
        :user_name, :first_name, :last_name,:phone, :hired_at, :personal_email,
        :emergency_contact_phone, :emergency_contact_name,
        :gender, :experience_in_months, :qualifications,
        :employee_type, :employment_type,:department_id,:job_position_id
      )

      user_params[:employees_attributes] = employee_params
      puts(employee_params,"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

    end

    user_params
  end


end
