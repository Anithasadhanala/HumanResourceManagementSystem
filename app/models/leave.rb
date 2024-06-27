class Leave < ApplicationRecord

  has_many :leave_requests

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :days_count, presence: true
  scope :active, -> { where(is_active: true) }


  def get_all_leaves
    Leave.all.active
  end


  def find_by_id(id)
    leave = Leave.active.find_by(id: id)
    if leave
      leave
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  def create_leave(params)
    Leave.create!(params)
  end


  def find_and_update_leave(params)
    leave = find_by_id(params[:id])
    if leave
      leave.update(params)
      leave
    end
  end


  def find_and_destroy(id)
    leave = find_by_id(id)
    if leave
      leave.update(is_active: false)
      { message: 'Leave deleted successfully' }
    else
      { error: "Leave with id: #{leave.id}  has associated employees!!!" }
    end
  end
end


