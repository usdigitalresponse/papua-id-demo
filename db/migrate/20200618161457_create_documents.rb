class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents, id: :uuid do |t|
      t.integer :document_type
      t.references :applicant, type: :uuid, null: false, foreign_key: true
      t.integer :descision
      t.jsonb :descision_response
      t.string :entity_id
      t.string :evaluation_id
      t.string :application_token
      t.string :application_version_id

      t.timestamps
    end
  end
end
