class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.decimal :price
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
