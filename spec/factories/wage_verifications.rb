FactoryBot.define do
  factory :wage_verification do
    applicant { nil }
    reported_employer_name { "Company Name" }
    reported_employer_id { "12345" }
    reported_termination_date { Date.today }
    reported_wages { 1000.0 }
    reported_time_period { "Weekly" }
    truework_verification_status { "NotStarted" }
  end
end
