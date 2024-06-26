class JobPosition < ApplicationRecord
  has_many :employees

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  scope :active, -> { where(is_active: true) }

  def get_all_job_positions
    JobPosition.all.active
  end

    def find_by_id(id)
      job_position = JobPosition.active.find_by(id: id)
      if job_position
        job_position
      else
        raise ActiveRecord::RecordNotFound
      end
    end

  def create_job_position(params)
    JobPosition.create!(
      title: params[:title],
      description: params[:description])
  end

  def find_and_update_job_position(params)
    job_position = find_by_id(params[:id])

    if job_position
      job_position.update(params)
      job_position
    end
  end


  def find_and_destroy_if_no_employees(id)
    job_position = find_by_id(id)
    if job_position && job_position.employees.empty?
      job_position.update(is_active: false)
      { message: 'Job position deleted successfully' }
    else
      { error: "Job position with id: #{job_position.id}  has associated employees!!!" }
    end
  end



end