class BankCredential < ApplicationRecord

  validates :account_type, presence: true
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  enum account_type: {
    salary: 'salary',
    personal: 'personal',
    family: 'family'
  }

  def account_type_is_valid_enum(type)
    self.class.account_types.key?(type.to_sym)
  end

  validates :bank_name, :account_number, :ifsc_code, :bank_branch_code,:bank_name, :account_type,:employee_id,:is_active,presence: true

  scope :active, -> { where(is_active: true) }

  def create_bank_credential(params)

    existing_inactive_record = account_type_is_valid_enum(params[:account_type]) && BankCredential.find_by(employee_id: params[:employee_id],account_type: params[:account_type], is_active: true)==nil

    if !existing_inactive_record
      raise ActiveRecord::RecordInvalid
    else
      BankCredential.create!(params)
      end
  end


  def find_and_update_bank_credential(params)

    bank_credential = Employee.new.get_bank_credential(params[:employee_id],params[:id])
    if bank_credential
      bank_credential.update(params)
      bank_credential
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def find_and_destroy_employee_bank_credential(employee_id, id)
    bank_credential = Employee.new.get_bank_credential(employee_id,id)
    if bank_credential
      bank_credential.update(is_active: false)
      { message: 'bank credential deleted successfully' }
    else
      { error: "bank credential with id: #{bank_credential.id}  has not found!!!" }
    end
  end

end
