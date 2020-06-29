class MaxBankAccountsValidator < ActiveModel::Validator
  ACCOUNT_LIMIT = 2

  def validate(record)
    if BankAccount.where(bank_account_number: record.bank_account_number, bank_routing_number: record.bank_routing_number).size >= ACCOUNT_LIMIT
      record.errors[:bank_account_number] << "Unable to store bank account information"
    end
  end
end

class BankAccount < ApplicationRecord
  validates :first_name, :last_name, :bank_account_number, :bank_routing_number, presence: true
  belongs_to :applicant, optional: true
  validates_with MaxBankAccountsValidator

  def full_name
    "#{first_name} #{last_name}"
  end

  def make_decision
    self.applicant.make_decision
  end
end
