# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidateRequest, type: :model do
  let(:constituency) { create(:constituency) }
  let(:user) { create(:user, :voter, id: 123, constituency: constituency.name) }

  let(:valid_picture) do
    build(:candidate_request, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/a1.jpeg')))
  end

  let(:in_valid_picture) do
    build(:candidate_request, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/a2.jpg')))
  end

  describe 'enums test' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending approved]) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:voter_id) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_length_of(:party).is_at_most(20) }
    it { is_expected.to validate_length_of(:constituency).is_at_most(4) }
  end

  describe 'Custom Validations' do
    context 'when image size' do
      it 'creates an object with image size of less than 1MB' do
        expect(valid_picture.save).to be(true)
      end

      it 'does not create an object with image size greater than 1MB' do
        expect(in_valid_picture.save).to be(false)
      end
    end

    context 'when update candidate status' do
      it 'change user status and creates a candidate' do
        user.save!
        expect(valid_picture.change_candidate_status).to be(true)
      end
    end
  end
end
