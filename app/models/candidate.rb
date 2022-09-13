# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :party, length: { maximum: 20 }
  validates :constituency, presence: true
end
