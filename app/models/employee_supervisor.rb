class EmployeeSupervisor < ApplicationRecord
  belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'
  belongs_to :supervisor, class_name: 'User', foreign_key: 'supervisor_id'
  belongs_to :supervisor, class_name: 'User', foreign_key: 'secondary_supervisor_id'

  validates :employee_id, presence: true
  validates :supervisor_id, presence: true

  end