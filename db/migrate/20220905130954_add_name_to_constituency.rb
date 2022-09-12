# frozen_string_literal: true

class AddNameToConstituency < ActiveRecord::Migration[5.2]
  def change
    add_column :constituencies, :name, :string
  end
end
