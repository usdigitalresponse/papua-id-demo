class BankAccount < ApplicationRecord
  validates :first_name, :last_name, :bank_account_number, :bank_routing_number, presence: true

  before_create :make_decision

  def full_name
    "#{first_name} #{last_name}"
  end
end
