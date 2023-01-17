# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:constituency) { create(:constituency) }
  let(:user) { create(:user, :voter, constituency: constituency.name) }
  let(:candidate) { create(:candidate, user_id: user.id, constituency: constituency.name.to_i) }
  let(:poll) { create(:poll, user_id: user.id) }

  let(:vote) { described_class.create(user_id: user.id, constituency_id: constituency.name.to_i, candidate_id: candidate.id, poll_id: poll.id) }
  let(:second_vote) { described_class.new(user_id: user.id, constituency_id: constituency.name.to_i, candidate_id: candidate.id, poll_id: vote.poll_id) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:candidate) }
    it { is_expected.to belong_to(:poll) }
    it { is_expected.to belong_to(:constituency) }
  end

  describe 'validation test' do
    context 'when voted by same user twice' do
      it 'ensures uniqueness of user_id and poll_id within scope of vote_id' do
        second_vote.valid?
        expect(second_vote.errors.full_messages.to_sentence).to include('User has already been taken')
      end
    end
  end
end
