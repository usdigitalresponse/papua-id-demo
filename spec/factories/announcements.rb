FactoryBot.define do
  factory :announcement do
    title { Faker::GreekPhilosophers.quote }
    content { Faker::Lorem.paragraphs(number: (3..12).to_a.sample) }
  end
end
