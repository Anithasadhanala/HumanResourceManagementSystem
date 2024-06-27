class V1::Entities::OnboardingCandidate < Grape::Entity
  expose :id,  if: {type: :full}
  expose :opening_id
  expose :name
  expose :email
  expose :phone
  end