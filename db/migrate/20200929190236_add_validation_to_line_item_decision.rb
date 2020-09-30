class AddValidationToLineItemDecision < ActiveRecord::Migration[6.0]
  def change
    add_reference :line_item_decisions, :validation, null: true, foreign_key: true, type: :uuid
  end
end
