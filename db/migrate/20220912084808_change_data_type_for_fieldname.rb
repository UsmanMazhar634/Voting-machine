# frozen_string_literal: true

class ChangeDataTypeForFieldname < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :cnic, :string
  end

  def down
    change_column :users, :cnic, :intiger
  end
end
