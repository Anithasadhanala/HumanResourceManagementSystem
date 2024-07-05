class Address < ApplicationRecord
  include AuthoriseUser
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  validates :d_no, :landmark, :city, :zip_code, :state, :country, presence: true
  scope :active, -> { where(is_active: true) }


  def get_all_addresses(employee_id)

    if employee_id.present?
      authorise_user(employee_id)
    else
      employee_id = Current.user.id
    end
      address = Address.active.where(employee_id: employee_id)
      if address
        address
      else
        raise ActiveRecord::RecordNotFound
      end
  end

  def find_by_id(id,employee_id)

    if employee_id.present?
      authorise_user(employee_id)
    end
      address = Address.active.find_by( id: id)
      if address
        address
      else
        raise ActiveRecord::RecordNotFound
      end
  end


  def employee_has_active_address_type?(employee_id,address_type)
    Address.where(is_permanent: address_type, is_active: true,employee_id: employee_id).exists?
  end


  def create_address(params)
    validate_address =  employee_has_active_address_type?(Current.user.id, params[:is_permanent])
    if validate_address
      raise RuntimeError, {message: "You cannot add this address type, already exists"}
    else
      params.merge!(employee_id: Current.user.id)
      Address.create!(params)
    end
  end


  def find_and_update_address(params)
    address = find_by_id(params[:id], Current.user.id)
    if address
      params  = params.merge(employee_id: Current.user.id)
      address.update(params)
      address
    end
  end


  def find_and_destroy_employee_address( id)
    address = find_by_id(id, Current.user.id)
    if address
      address.update(is_active: false)
      { message: "address deleted successfully with id : #{address.id}" }
    else
      { error: "address with id: #{address.id}  has not found!!!" }
    end
  end
end
