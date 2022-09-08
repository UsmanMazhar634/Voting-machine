# frozen_string_literal: true

class CandidateRequest < ApplicationRecord
  enum status: %i[pending approved]
end
