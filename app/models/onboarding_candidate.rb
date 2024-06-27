class OnboardingCandidate < ApplicationRecord
  belongs_to :opening

  def create_onboarding_candidate(params)
    OnboardingCandidate.create!(params)
  end


  def create_onboarding_candidates(candidates_params)
    # errors = []
     candidates = []

    candidates_params.each do |candidate_params|
      puts(candidate_params,"//////////////////////////////////////////////////////////")
      candidate = OnboardingCandidate.new(opening_id: candidate_params[:opening_id],
                                          name: candidate_params[:name],
                                          email: candidate_params[:email],
                                          phone: candidate_params[:phone],)
      if candidate.save
        puts("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        candidates << candidate
      else
        raise ActiveRecord::RecordInvalid
        # errors << candidate.errors.full_messages
      end
    end
     candidates
  end


end
