class Payroll < ApplicationRecord
  belongs_to :user
  has_many :payroll_histories

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'
  validates :base_payroll,  presence: true

end