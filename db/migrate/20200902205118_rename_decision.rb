class RenameDecision < ActiveRecord::Migration[6.0]
  def change
  	rename_column :documents, :descision, :decision
  	rename_column :documents, :descision_response, :decision_response
  	rename_column :applicants, :descision, :decision
  	rename_column :applicants, :descision_response, :decision_response
  end
end
