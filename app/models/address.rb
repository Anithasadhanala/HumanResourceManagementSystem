class Address < ApplicationRecord
  include AuthoriseUser
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  validates :d_no, :landmark, :city, :zip_code, :state, :country, presence: true
  scope :active, -> { where(is_active: true) }


  def get_all_addresses(employee_id)
    authorise_user(employee_id)
      address = Address.active.where(employee_id: employee_id)
      if address
        address
      else
        raise ActiveRecord::RecordNotFound
      end
  end

  def find_by_id(employee_id,id)
     authorise_user(employee_id)
      address = Address.active.find_by( id: id, employee_id: employee_id )
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
    authorise_user(params[:employee_id])
    validate_address =  employee_has_active_address_type?(params[:employee_id], params[:is_permanent])
    if validate_address
      raise RuntimeError, {message: "You cannot add this address type, already exists"}
    else
      Address.create!(params)
    end
  end


  def find_and_update_address(params)
    authorise_user(params[:employee_id])
    address = find_by_id(params[:employee_id],params[:id])
    if address
      address.update(params.except(:is_permanent))
      address
    end
  end


  def find_and_destroy_employee_address(employee_id, id)
    authorise_user(params[:employee_id])
    address = find_by_id(employee_id,id)
    if address
      address.update(is_active: false)
      { message: "address deleted successfully with id : #{address.id}" }
    else
      { error: "address with id: #{address.id}  has not found!!!" }
    end
  end
end
