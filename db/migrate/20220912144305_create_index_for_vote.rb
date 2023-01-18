# frozen_string_literal: true

class CreateIndexForVote < ActiveRecord::Migration[5.2]
  def change
    add_index :votes, %i[poll_id user_id], unique: true
  end
end
