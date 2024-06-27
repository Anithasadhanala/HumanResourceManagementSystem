class Department < ApplicationRecord

  has_many :employees

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  scope :active, -> { where(is_active: true) }

  def get_all_departments
    Department.all.active
  end

  def find_by_id(id)
    department = Department.active.find_by(id: id)
    if department
      department
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create_department(params)
    Department.create!(
      name: params[:name],
      description: params[:description])
  end

  def find_and_update_department(params)
    department = find_by_id(params[:id])

    if department
      department.update(params)
      department
    end
  end

  def find_and_destroy_if_no_employees(id)
    department = find_by_id(id)
    if department && department.employees.empty?
      department.destroy
      { message: 'Department deleted successfully' }
    else
      { error: "Department with id: #{department.id}  has associated employees!!!" }
    end
  end
end