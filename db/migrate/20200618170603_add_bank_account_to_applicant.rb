class AddBankAccountToApplicant < ActiveRecord::Migration[6.0]
  def change
    add_reference :bank_accounts, :applicant
  end
end
