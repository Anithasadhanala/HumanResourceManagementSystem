class Opening < ApplicationRecord

  belongs_to :job_position
  belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'
  has_many :openings
  has_many :onboarding_candidates


def create_opening(params)
  params = params.merge(created_by_id: Current.user.id)
  Opening.create!(params)
end


  def find_and_update_opening(params)
    opening = Opening.find(params[:id])
   opening.update(params.except(:created_by_id))
    opening
  end


  def get_all_onboarding_candidates_for_opening(opening)
    openings = opening.onboarding_candidates
    if openings
      openings
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def find_onboarding_candidate_by_id(opening, id)
    opening.onboarding_candidates.find(id)
  end
end