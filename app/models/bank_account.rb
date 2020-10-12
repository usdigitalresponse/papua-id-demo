class BankAccount < ApplicationRecord
  ACCOUNT_LIMIT = 2
  belongs_to :applicant
  validates :first_name, :last_name, :bank_account_number, :bank_routing_number, presence: true
  validate :check_for_multiples
  has_many :line_item_decisions, as: :decidable

  after_create_commit :make_decision

  def full_name
    "#{first_name} #{last_name}"
  end

  protected

  def make_decision
    VerifyBankAccountJob.set(wait: 1.second).perform_later(self.id)
  end

  def check_for_multiples
    if BankAccount.where(bank_account_number: bank_account_number, bank_routing_number: bank_routing_number).count >= ACCOUNT_LIMIT
      record.errors[:bank_account_number] << "Unable to store bank account information"
    end
  end
end
