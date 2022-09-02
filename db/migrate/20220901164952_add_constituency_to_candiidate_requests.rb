class AddConstituencyToCandiidateRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :candidate_requests, :constituency, :string
  end
end
