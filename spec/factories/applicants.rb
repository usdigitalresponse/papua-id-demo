FactoryBot.define do
  factory :applicant do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthdate { Faker::Date.between(from: 18.years.ago, to: 75.years.ago) }
    email_address { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postal_code { Faker::Address.zip.gsub(/-\d{4}/, '') }
    ssn { Faker::IDNumber.valid.gsub(/-/, '').to_i }
    case_number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
  end
end
