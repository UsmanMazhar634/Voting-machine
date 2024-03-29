# frozen_string_literal: true

class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
