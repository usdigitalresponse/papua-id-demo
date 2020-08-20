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
    ssn { Faker::IDNumber.valid.gsub(/-/, '') }
    case_number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }

    trait :sandboxed do
      ssn { EXAMPLES.to_a.sample[1] }
    end

    trait :with_wage_verification do
      after(:create) do |applicant|
        create :wage_verification,
          applicant: applicant,
          reported_employer_name: Faker::Company.name,
          reported_employer_id: rand(100000..1000000),
          reported_termination_date: Date.today - rand(1..100),
          reported_wages: rand(10000..1000000) / 100.0,
          reported_time_period: "Weekly",
          truework_verification_status: "NotStarted"
      end
    end

  end
end
