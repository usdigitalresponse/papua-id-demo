class AddDescisionInfoToApplicant < ActiveRecord::Migration[6.0]
  def change
    add_column :applicants, :descision, :integer
    add_column :applicants, :descision_response, :jsonb
    add_column :applicants, :entity_id, :string
    add_column :applicants, :evaluation_id, :string
    add_column :applicants, :application_token, :string
    add_column :applicants, :application_version_id, :string
  end
end
