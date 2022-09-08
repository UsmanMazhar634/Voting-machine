# frozen_string_literal: true

class AddConstituencyToVote < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :constituency, foreign_key: true
  end
end
