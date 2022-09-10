# frozen_string_literal: true

class CandidateRequest < ApplicationRecord
  include ImageUploader::Attachment(:image)
  enum status: { pending: 0, approved: 1 }
end
