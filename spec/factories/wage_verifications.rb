FactoryBot.define do
  factory :wage_verification_unverified do
    applicant { nil }
    reported_wages { 9.99 }
    reported_employer_name { "Company Name" }
    reported_employer_id { "12345" }
    reported_time_period { "monthly" }
    reported_termination_date { "2020-07-01" }
    truework_verification_status { "NotStarted" }
  end
end
