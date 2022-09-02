class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :candidate, foreign_key: true
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
