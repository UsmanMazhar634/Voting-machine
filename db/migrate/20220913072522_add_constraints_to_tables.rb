# frozen_string_literal: true

# Migration for constraints
class AddConstraintsToTables < ActiveRecord::Migration[5.2]
  def self.up
    change_column :users, :first_name, :string, null: false, limit: 15
    change_column :users, :last_name, :string, null: false, limit: 15
    change_column :users, :cnic, :string, null: false, limit: 13, unique: true
    change_column :users, :role, :integer, null: false
    change_column :users, :constituency, :string, null: false, limit: 4
    change_column :users, :image_data, :text, null: true

    change_column :candidate_requests, :voter_id, :integer, null: false
    change_column :candidate_requests, :party, :string, null: false, limit: 20
    change_column :candidate_requests, :status, :integer, null: false
    change_column :candidate_requests, :constituency, :string, null: false, limit: 4
    change_column :candidate_requests, :image_data, :text, null: true

    change_column :candidates, :party, :string, null: false, limit: 20
    change_column :candidates, :constituency, :bigint, null: false

    change_column :constituencies, :name, :string, null: false, limit: 4

    change_column :polls, :start_date, :datetime, null: false
    change_column :polls, :end_date, :datetime, null: false

    remove_column :candidates, :symbol
  end

  def self.down
    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
    change_column :users, :cnic, :string
    change_column :users, :role, :integer
    change_column :users, :constituency, :string
    change_column :users, :image_data, :text

    change_column :candidate_requests, :voter_id, :integer
    change_column :candidate_requests, :party, :string
    change_column :candidate_requests, :status, :integer
    change_column :candidate_requests, :constituency, :string
    change_column :candidate_requests, :image_data, :text

    change_column :candidates, :party, :string
    change_column :candidates, :constituency, :bigint

    change_column :constituencies, :name, :string

    change_column :polls, :start_date, :datetime
    change_column :polls, :end_date, :datetime

    add_column :candidates, :symbol
  end
end
