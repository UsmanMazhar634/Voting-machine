# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    party { Faker::Verb.base }
  end
end
