# frozen_string_literal: true

class DeleteName < ActiveRecord::Migration[5.2]
  def change
    reversible do
      remove_column :constituencies, :name
    end
  end
end
