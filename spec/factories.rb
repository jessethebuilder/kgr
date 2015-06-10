FactoryGirl.define do
  sequence(:email){ |n| "test_email#{n}@test.com"}


  factory :event do
    name Faker::Company.bs.titlecase
    start_time Time.now + Random.rand(1..800).hours.minutes
  end

  factory :dj do
    name Faker::Name.name
    email
  end

  factory :news_story do
    title Faker::Company.bs.titlecase
  end

  factory :user do
    email
    password 'carltonlasiter'
  end
end