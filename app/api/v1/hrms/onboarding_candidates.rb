class V1::Hrms::OnboardingCandidates < Grape::API
  before { authenticate_user! }

  resources :openings do
    route_param :opening_id do

      before do
        @opening = Opening.find_by(id: params[:opening_id])
        error!({ error: "Opening not found" }, 404) unless @opening
      end

      resources :onboarding_candidates do
        before { authenticate_admin! }
        # Endpoint, gives all onboarding_candidates----------------------------------------------------------------------------------------
        desc 'Return all onboarding_candidates'
        params do
          optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
          optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
        end

        get do
          onboarding_candidate = Opening.new.get_all_onboarding_candidates_for_opening(@opening)
          onboarding_candidate = paginate(onboarding_candidate)
          present( onboarding_candidate, with: V1::Entities::OnboardingCandidate, type: :full)
        end

        # Endpoint to get a specific onboarding_candidate by ID-------------------------------------------------------------------------------
        desc 'Return a specific onboarding_candidate'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          onboarding_candidate = Opening.new.find_onboarding_candidate_by_id(@opening,params[:id])
          if onboarding_candidate
            present onboarding_candidate, with: V1::Entities::OnboardingCandidate, type: :full
          else
            {error: "Record not found"}
          end
        end


        # Endpoint to create a new onboarding_candidate ---------------------------------------------------------------------------------------
        desc 'Create a new onboarding_candidate'
        params do
          requires :onboarding_candidates, type: Array do
            requires :name, type: String
            requires :email, type: String
            requires :phone, type: String
            requires :opening_id, type: Integer
          end
        end

        post do
          onboarding_candidate = OnboardingCandidate.new.create_onboarding_candidates(params[:onboarding_candidates])
          present onboarding_candidate, with: V1::Entities::OnboardingCandidate, type: :full
        end
      end
    end
  end
end
