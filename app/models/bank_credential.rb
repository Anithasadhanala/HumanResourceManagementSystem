class BankCredential < ApplicationRecord
  include AuthoriseUser

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  validates :bank_name, :account_number, :ifsc_code, :bank_branch_code,:bank_name, :account_type,:employee_id,:is_active,presence: true
  validates :account_type, presence: true
  scope :active, -> { where(is_active: true) }



  enum account_type: {
    salary: 'salary',
    personal: 'personal',
    family: 'family'
  }

  def account_type_is_valid_enum(type)
    self.class.account_types.key?(type.to_sym)
  end


  def create_bank_credential(params)
    existing_inactive_record = account_type_is_valid_enum(params[:account_type]) && BankCredential.find_by(employee_id: Current.user.id,account_type: params[:account_type], is_active: true)==nil
    if !existing_inactive_record
      raise RuntimeError, {message: "cannot create this bank credential details, this bank credential type already exists!!"}
    else
      params = params.merge(employee_id: Current.user.id)
      BankCredential.create!(params)
    end
  end


  def find_and_update_bank_credential(params)
    bank_credential = Employee.new.get_bank_credential(params[:id],Current.user.id)
    if bank_credential
      bank_credential.update(params)
      bank_credential
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def find_and_destroy_employee_bank_credential( id)
    bank_credential = Employee.new.get_bank_credential(id,Current.user.id)
    if bank_credential
      bank_credential.update(is_active: false)
      { message: 'bank credential deleted successfully' }
    else
      { error: "bank credential with id: #{bank_credential.id}  has not found!!!" }
    end
  end
end
