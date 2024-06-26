class CreateUserJwtTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :user_jwt_tokens, force: :cascade do |t|
      t.integer :user_id, null: false
      t.string :jwt_token, null: false
      t.boolean :is_active, default: true

      t.index :user_id, name: "index_user_jwt_tokens_on_user_id"
      t.foreign_key :users, column: :user_id
    end
  end
end
