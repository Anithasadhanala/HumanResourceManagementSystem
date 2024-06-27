class CreateEmployeeDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_documents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.string :document_link, null: false
      t.string :document_number, null: false
      t.date :issued_at, null: false
      t.string :expires_at, null: false
      t.timestamps
    end
  end
end
