# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Poll, type: :model do
  def constituency
    create(:constituency)
  end

  def user
    create(:user, :admin, constituency: constituency.name)
  end

  def poll_with_start_and_end_date
    described_class.create(user_id: user.id, start_date: Faker::Date.between(from: 2.days.ago, to: Time.zone.today), end_date: Faker::Date.forward(days: 10), created_at: Time.current,
                           updated_at: Time.current)
  end

  let(:poll_with_only_start_date) do
    described_class.new(user_id: user.id, start_date: Faker::Date.between(from: 2.days.ago, to: Time.zone.today),
                        created_at: Time.current, updated_at: Time.current)
  end

  let(:poll_with_only_end_date) do
    described_class.new(user_id: user.id, end_date: Faker::Date.forward(days: 10),
                        created_at: Time.current, updated_at: Time.current)
  end

  let(:poll_without_start_and_end_date) do
    described_class.new(user_id: user.id, created_at: Time.current,
                        updated_at: Time.current)
  end

  let(:poll_with_end_date_before_the_start_date) do
    described_class.new(user_id: user.id, start_date: Faker::Date.between(from: 2.days.ago, to: Time.zone.today),
                        end_date: Faker::Date.backward(days: 10), created_at: Time.current, updated_at: Time.current)
  end

  let(:poll_with_end_date_after_the_start_date) do
    described_class.create(user_id: user.id, start_date: Faker::Date.between(from: 2.days.ago, to: Time.zone.today),
                           end_date: Faker::Date.forward(days: 10), created_at: Time.current, updated_at: Time.current)
  end

  describe 'associations tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  describe 'custom validation tests' do
    it 'creates a poll with start_date and end_date' do
      expect(poll_with_start_and_end_date).to be_valid
    end

    it "can't create a poll with only start_date" do
      poll_with_only_start_date.valid?
      expect(poll_with_only_start_date.errors.full_messages.to_sentence).to include("End date can't be blank")
    end

    it "can't create a poll with only end_date" do
      poll_with_only_end_date.valid?
      expect(poll_with_only_end_date.errors.full_messages.to_sentence).to include("Start date can't be blank")
    end

    it "can't create a poll without start_date and end_date" do
      poll_without_start_and_end_date.valid?
      expect(poll_without_start_and_end_date.errors.full_messages.to_sentence).to include("Start date can't be blank and End date can't be blank")
    end

    it 'create a poll with end_date after the start_date' do
      expect(poll_with_end_date_after_the_start_date).to be_valid
    end

    it "can't create a poll with end_date before the start_date" do
      poll_with_end_date_before_the_start_date.valid?
      expect(poll_with_end_date_before_the_start_date.errors.full_messages.to_sentence).to include('End date cannot be before the start date')
    end
  end
end
