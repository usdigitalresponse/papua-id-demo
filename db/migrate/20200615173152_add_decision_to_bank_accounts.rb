class AddDecisionToBankAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :decision, :string
  end
end
