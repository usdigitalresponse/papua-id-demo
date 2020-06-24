require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it "Makes sure that only bank accounts can only exist a maximum of twice" do
    first_account = FactoryBot.create(:bank_account)
    second_account = FactoryBot.create(:bank_account, bank_account_number: first_account.bank_account_number, bank_routing_number: first_account.bank_routing_number)

    third_account = FactoryBot.build(:bank_account, bank_account_number: first_account.bank_account_number, bank_routing_number: first_account.bank_routing_number)
    third_account.save
    expect(third_account.errors[:bank_account_number]).to eq(["Unable to store bank account information"])
  end
end
