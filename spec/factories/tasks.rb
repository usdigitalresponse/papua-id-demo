FactoryBot.define do
  factory :task do
    title { [
      'Review new initial claim',
      'Review new weekly certification',
      'Review claim for fraud',
      'Verify claimant identity',
      'Verify claimant employment and wages'
    ].sample }
    applicant_id { Applicant.all.pluck(:id).sample }
    status { 1 }
    due_on { Faker::Date.between(from: 20.days.ago, to: 17.days.from_now) }
  end
end
