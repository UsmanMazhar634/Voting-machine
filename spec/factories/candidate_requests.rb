# frozen_string_literal: true

FactoryBot.define do
  factory :candidate_request do
    voter_id { 123 }
    traits_for_enum :status, %w[pending approved]
    party { Faker::Verb.base }
    constituency { Faker::Number.within(range: 0..10_000).to_s }
  end
end
