class AddSourcesToLineItemDecisions < ActiveRecord::Migration[6.0]
  def change
    add_column :line_item_decisions, :sources, :string, array: true, null: false, default: []
  end
end
