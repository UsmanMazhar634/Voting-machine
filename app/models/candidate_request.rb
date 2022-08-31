class CandidateRequest < ApplicationRecord
  enum status: [:pending, :approved]
end
