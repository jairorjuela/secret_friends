class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :worker, null: false, foreign_key: true
      t.integer :couple_number, null: false
      t.string :year_game, null: false

      t.timestamps
    end
  end
end
