class AddDecisionToWageVerification < ActiveRecord::Migration[6.0]
  def change
    add_column :wage_verifications, :decision, :integer, limit: 2
  end
end
