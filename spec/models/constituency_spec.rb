# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Constituency, type: :model do
  describe 'associations tests' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_length_of(:name).is_at_most(4) }
  end
end
