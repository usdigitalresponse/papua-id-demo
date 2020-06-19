class BankAccount < ApplicationRecord
  validates :first_name, :last_name, :bank_account_number, :bank_routing_number, presence: true
  belongs_to :applicant, optional: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def make_decision
    self.applicant.make_decision
  end
end
