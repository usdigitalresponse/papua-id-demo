class SetUnprocessedDescisions < ActiveRecord::Migration[6.0]
  def change
    Applicant.where(descision: nil).update_all descision: -2
    Document.where(descision: nil).update_all descision: -2
    change_column :applicants, :descision, :integer, limit: 2, null: false, default: -2
    change_column :documents, :descision, :integer, limit: 2, null: false, default: -2
  end
end
