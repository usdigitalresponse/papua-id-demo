class AddStatusToApplicants < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :status, :integer, null: false, default: 1
  end
end
