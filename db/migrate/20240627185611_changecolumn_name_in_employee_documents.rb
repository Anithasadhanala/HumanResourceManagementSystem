class ChangecolumnNameInEmployeeDocuments < ActiveRecord::Migration[7.1]
  def change
    rename_column :employee_documents, :type, :document_type
  end
end
