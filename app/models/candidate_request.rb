# frozen_string_literal: true

class CandidateRequest < ApplicationRecord
  include ImageUploader::Attachment(:image)

  after_update :change_candidate_status

  enum status: { pending: 0, approved: 1 }

  validates :voter_id, :constituency, :party, presence: true

  private

  def change_candidate_status
    @user = User.find(voter_id)
    @user.candidate!
    @user.save!

    new_candidate = Candidate.create(user_id: voter_id, party: party, constituency: constituency)
    new_candidate.save!
  end
end
