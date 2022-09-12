# frozen_string_literal: true

class ChangeDataTypeForFieldname < ActiveRecord::Migration[5.2]
  def change
    change_column(:users, :cnic, :string)
  end
end
