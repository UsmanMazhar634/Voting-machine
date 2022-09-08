# frozen_string_literal: true

class AddConstituencyToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :constituency, :string
  end
end
