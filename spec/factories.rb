FactoryGirl.define do
  factory :event do
    name Faker::Company.bs.titlecase
    start_time Time.now + Random.rand(1..800).hours.minutes
  end

  factory :dj do
    name Faker::Name.name
  end

  factory :news_story do
    title Faker::Company.bs.titlecase
  end
end