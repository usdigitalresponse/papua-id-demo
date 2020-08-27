class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title, null: false
      t.references :applicant, type: :uuid, null: false, foreign_key: true
      t.integer :status, null: false
      t.date :due_on

      t.timestamps
    end
  end
end
