class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :symbol
      t.string :party
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
