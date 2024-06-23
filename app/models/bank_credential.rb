class BankCredential < ApplicationRecord
  belongs_to :employee

  enum account_type: {
    personal: 'PERSONAL',
    salary: 'SALARY',
    pf: 'PF'
  }

  validates :bank_name, :bank_branch_place, :account_number, :ifsc_code, :bank_branch_code, :account_type,:employee_id,:is_active,presence: true

  scope :active, -> { where(is_active: true) }

  def get_all_bank_credentials(employee_id)
    BankCredential.where(employee_id: employee_id).active
  end

  def find_by_id(employee_id,id)
    bank_credential = BankCredential.active.find_by( id: id, employee_id: employee_id )
    if bank_credential
      bank_credential
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create_bank_credential(params)
    existing_inactive_record = BankCredential.find_by(account_type: BankCredential.account_types[params[:account_type]], is_active: true)

    if existing_inactive_record
      raise ActiveRecord::RecordInvalid
    else
      BankCredential.create!(
        employee_id: params[:employee_id],
        bank_name: params[:bank_name],
        bank_branch_place: params[:bank_branch_place],
        account_number: params[:account_number],
        ifsc_code: params[:ifsc_code],
        bank_branch_code: params[:bank_branch_code],
        account_type: BankCredential.account_types[params[:account_type]],
        is_active: params[:is_active])
      end
  end


  def find_and_update_bank_credential(params)
    bank_credential = BankCredential.find_by_id(params[:employee_id],params[:id])
    if bank_credential
      bank_credential.update(params)
      bank_credential
    end
  end


  def find_and_destroy_employee_bank_credential(employee_id, id)
    bank_credential = find_by_id(employee_id,id)
    if bank_credential
      bank_credential.update(is_active: false)
      { message: 'bank credential deleted successfully' }
    else
      { error: "bank credential with id: #{bank_credential.id}  has not found!!!" }
    end
  end

end
