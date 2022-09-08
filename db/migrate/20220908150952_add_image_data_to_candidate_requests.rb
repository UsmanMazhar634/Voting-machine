class AddImageDataToCandidateRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :candidate_requests, :image_data, :text
  end
end
