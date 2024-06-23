class Address < ApplicationRecord
  belongs_to :employee
  validates :d_no, :landmark, :city, :zip_code, :state, :country, presence: true


  scope :active, -> { where(is_active: true) }

  def get_all_addresses(employee_id)
    Address.find_by(employee_id: employee_id).active
  end

  def find_by_id(employee_id,id)
    address = Address.active.find_by( id: id, employee_id: employee_id )
    if address
      address
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create_address(params)
      Address.create!(
      employee_id: params[:employee_id],
      d_no: params[:d_no],
      landmark: params[:landmark],
      city: params[:city],
      zip_code: params[:zip_code],
      state: params[:state],
      country: params[:country],
      is_permanent: params[:is_permanent])
  end

  def find_and_update_address(params)
    address = find_by_id(params[:employee_id],params[:id])
    if address
      address.update(params)
      address
    end
  end


  def find_and_destroy_employee_address(employee_id, id)
    address = find_by_id(employee_id,id)
    if address
      address.update(is_active: false)
      { message: 'address deleted successfully' }
    else
      { error: "address with id: #{address.id}  has not found!!!" }
    end
  end

end
