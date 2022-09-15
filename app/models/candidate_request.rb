# frozen_string_literal: true

class CandidateRequest < ApplicationRecord
  include ImageUploader::Attachment(:image)

  enum status: { pending: 0, approved: 1 }

  validate :check_image_size
  validates :voter_id, :status, presence: true
  validates :party, length: { maximum: 20 }
  validates :constituency, length: { maximum: 4 }

  def change_candidate_status
    @user = User.find(voter_id)
    @user.candidate!
    @user.save!

    new_candidate = Candidate.create(user_id: voter_id, party: party, constituency: constituency)
    new_candidate.save!
  end

  def check_image_size
    errors.add(:image, 'Image size must not be greater then 1 mb') if image.size > 1.megabytes
  end
end
