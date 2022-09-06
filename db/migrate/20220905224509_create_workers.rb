class CreateWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :workers do |t|
      t.references :location, null: false, foreign_key: true
      t.string :name, null: false
      t.string :year_game, null: false

      t.timestamps
    end
  end
end
