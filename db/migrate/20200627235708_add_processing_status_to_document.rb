class AddProcessingStatusToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :processing_status, :integer, null: false, default: 0
  end
end
