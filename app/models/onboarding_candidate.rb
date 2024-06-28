class OnboardingCandidate < ApplicationRecord
  belongs_to :opening

  def create_onboarding_candidate(params)
    OnboardingCandidate.create!(params)
  end


  def create_onboarding_candidates(candidates_params)
     candidates = []
    candidates_params.each do |candidate_params|
      candidate = OnboardingCandidate.new(opening_id: candidate_params[:opening_id],
                                          name: candidate_params[:name],
                                          email: candidate_params[:email],
                                          phone: candidate_params[:phone])

      opening = Opening.find(candidate_params[:opening_id])
      if opening.occupancy_count >= opening.openings_count
        raise RuntimeError, {message: "vacancies are filled, no more to fill."}
      end
      opening.update(occupancy_count: opening.occupancy_count.to_i + 1)
      if candidate.save
        candidates << candidate
      else
        raise ActiveRecord::RecordInvalid
      end
    end
     candidates
  end
end
