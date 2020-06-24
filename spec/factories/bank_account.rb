FactoryBot.define do
  factory :bank_account do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  bank_account_number { Faker::Bank.account_number }
  bank_routing_number { Faker::Bank.routing_number }
  end
end