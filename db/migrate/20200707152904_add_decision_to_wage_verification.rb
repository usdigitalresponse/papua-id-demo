class AddDecisionToWageVerification < ActiveRecord::Migration[6.0]
  def change
    add_column :wage_verifications, :decision, :integer
  end
end
