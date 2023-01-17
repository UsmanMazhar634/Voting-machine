# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'associations tests' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:constituency) }
    it { is_expected.to validate_length_of(:party).is_at_most(20) }
  end
end
