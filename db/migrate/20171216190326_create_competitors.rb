class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.string :name
      t.boolean :paid
      t.integer :number_races
      t.references :competition, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
