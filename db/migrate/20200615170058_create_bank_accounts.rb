class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :bank_account_number
      t.string :bank_routing_number

      t.timestamps
    end
  end
end
