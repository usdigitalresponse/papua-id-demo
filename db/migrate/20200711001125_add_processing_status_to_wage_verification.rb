class AddProcessingStatusToWageVerification < ActiveRecord::Migration[6.0]
  def change
    add_column :wage_verifications, :processing_status, :integer, limit: 2, default: 0, null: false
  end
end
