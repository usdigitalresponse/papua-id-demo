class RenameVerificationStatusToProcessingStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :wage_verifications, :verification_status, :processing_status
  end
end
