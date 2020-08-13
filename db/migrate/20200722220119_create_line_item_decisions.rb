class CreateLineItemDecisions < ActiveRecord::Migration[6.0]
  def change
    create_table :line_item_decisions, id: :uuid do |t|
      t.string :name
      t.string :decision
      t.uuid :decidable_id
      t.string :decidable_type
      t.timestamps
    end

    add_index :line_item_decisions, [:decidable_type, :decidable_id]
  end
end
