class AddColumnInEmployee < ActiveRecord::Migration[7.1]
  def change
    add_reference :employees, :onboarding_candidate, foreign_key: true
  end
  end
