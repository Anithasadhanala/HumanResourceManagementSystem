class ChangeJwtTokenToNotNullInUserJwtTokens < ActiveRecord::Migration[7.1]
  def change
    change_column :user_jwt_tokens, :created_at, :datetime, null: false
    change_column :user_jwt_tokens, :updated_at, :datetime, null: false
  end
end
