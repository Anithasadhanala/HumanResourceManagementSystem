class AddJwtTokenAndIsActiveToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :user_jwt_tokens, :created_at, :datetime
    add_column :user_jwt_tokens, :updated_at, :datetime
  end
end
