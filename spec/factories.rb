require 'support/request_specs_helper'

FactoryGirl.define do
  sequence(:email){ |n| "test_email#{n}@test.com"}
  pw = RequestSpecsHelper::PW


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
    password pw

    factory :admin do
      admin true
    end
  end

  factory :gallery do
    name Faker::Company.catch_phrase
  end

  factory :gallery_image do
    after(:build) do |img, eval|
      fn = File.join(Rails.root, 'app/assets/images/demo', "user_sample#{Random.rand(1..2)}.jpg")
      img.image = File.new(fn)
    end
  end
end