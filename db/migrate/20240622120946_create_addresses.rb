class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :d_no, null: false
      t.string :landmark, null: false
      t.string :city, null: false
      t.string :zip_code, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :address_type, null: false

      t.timestamps
    end
  end
end
