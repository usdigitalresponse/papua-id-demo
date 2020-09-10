class CreateValidation < ActiveRecord::Migration[6.0]
  def change
    create_table :validations, id: :uuid do |t|
      t.references :applicant, type: :uuid, null: false
      t.string :type, null: false
      t.jsonb :input
      t.jsonb :output
      t.integer :status, default: 0, null: false
      t.integer :decision
    end
  end
end
