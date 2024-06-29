class AddIsOnboardedToOnboardingcandidates < ActiveRecord::Migration[7.1]
  def change
    add_column :onboarding_candidates, :is_onboarded, :boolean, default: false
  end
end
