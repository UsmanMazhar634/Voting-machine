# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations tests' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:polls).dependent(:destroy) }
  end

  describe 'enums test' do
    it { is_expected.to define_enum_for(:role).with_values(%i[voter admin candidate]) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_length_of(:cnic).is_equal_to(13) }
    it { is_expected.to validate_length_of(:constituency).is_at_most(4) }
  end
end
