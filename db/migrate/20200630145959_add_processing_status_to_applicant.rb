class AddProcessingStatusToApplicant < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :processing_status, :integer, null: false, default: 0
  end
end
