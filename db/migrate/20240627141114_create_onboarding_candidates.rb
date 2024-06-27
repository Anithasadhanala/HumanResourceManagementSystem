class CreateOnboardingCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :onboarding_candidates do |t|
      t.references :opening, foreign_key: { to_table: :openings }, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
