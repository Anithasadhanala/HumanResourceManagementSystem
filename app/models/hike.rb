class Hike < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  def create_hike(params)
    if Hike.exists?(employee_id: params[:employee_id], is_active: true)
      raise RuntimeError, message: "You cannot add this Hike, employee with id:  #{params[:employee_id]} has the active hike!!!"
    end
    Hike.create!(params)
  end


  def find_and_update_hike(params)
    hike = Hike.find_by(employee_id: params[:employee_id],id: params[:id])
    if hike
      hike.update!(params.except(:is_active))
      hike
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def find_and_destroy_employee_hike(hike_id, employee_id)
    hike = Hike.find_by(employee_id: employee_id,id: hike_id)
    if hike
      hike.update(is_active: false)
      ("hike column deleted with id: #{hike_id}")
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end