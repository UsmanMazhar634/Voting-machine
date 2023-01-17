# frozen_string_literal: true

FactoryBot.define do
  factory :poll do
    start_date { Faker::Date.between(from: 2.days.ago, to: Time.zone.today) }
    end_date { Faker::Date.forward(days: 23) }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
