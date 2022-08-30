class CreateCandidateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_requests do |t|
      t.integer :voter_id
      t.string :party

      t.timestamps
    end
  end
end
