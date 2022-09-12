# frozen_string_literal: true

class ChangeTablenameFieldname < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :candidates do |t|
        dir.up   { t.change :constituency, 'bigint USING constituency::bigint' }
        dir.down { t.change :constituency, :string }
      end
    end
  end
end
