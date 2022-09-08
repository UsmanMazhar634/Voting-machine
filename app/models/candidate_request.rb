# frozen_string_literal: true

class CandidateRequest < ApplicationRecord
  include ImageUploader::Attachment(:image)
  enum status: %i[pending approved]
end
