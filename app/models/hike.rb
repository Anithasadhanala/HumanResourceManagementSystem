class Hike < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  def create_hike(params)

    hike = Hike.create!(params)
    payroll = Payroll.find_by(employee_id: params[:employee_id])
    changed_payroll = (payroll.base_payroll.to_i*(params[:percentage_value].to_i/100.0)) + payroll.base_payroll.to_i
    puts(params[:percentage_value])
    puts(((params[:percentage_value].to_i)/100.0 ),changed_payroll,"++++++++++++++")
    payroll.update(base_payroll: changed_payroll)
    hike
  end


  def find_and_update_hike(params)
    hike = Hike.find_by(employee_id: params[:employee_id],id: params[:id])
    if hike
      hike.update!(is_active: false)
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