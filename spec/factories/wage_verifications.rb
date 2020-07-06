FactoryBot.define do
  factory :wage_verification do
    applicant { nil }
    reported_employer_name { "Company Name" }
    reported_employer_id { "12345" }
    truework_verification_status { "NotStarted" }
  end
end
