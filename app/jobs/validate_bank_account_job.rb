class ValidateBankAccountJob < ApplicationJob
  queue_as :default

  def perform(bank_account_id)
    bank_account = BankAccount.find(bank_account_id)

    LineItemDecision.create(name: :bank_account_number, decision: :approved, decidable: bank_account)
    LineItemDecision.create(name: :bank_routing_number, decision: :approved, decidable: bank_account)
  end
end