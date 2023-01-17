# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    traits_for_enum :role, %w[voter admin candidate]
    email { Faker::Internet.email }
    cnic { Faker::Number.number(digits: 13) }
    # constituency { Faker::Number.within(range: 0..10000) }
    first_name { Faker::Name.name[2..15] }
    last_name { Faker::Name.name[2..15] }
    password { Faker::Internet.password(min_length: 6) }
  end
end
