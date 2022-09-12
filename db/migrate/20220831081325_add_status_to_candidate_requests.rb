# frozen_string_literal: true

class AddStatusToCandidateRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :candidate_requests, :status, :integer, default: 0
  end
end
