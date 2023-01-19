# frozen_string_literal: true

FactoryBot.define do
  id = Faker::Number.within(range: 0..10_000)
  factory :constituency do
    name { id.to_s }
    id { id }
  end
end
