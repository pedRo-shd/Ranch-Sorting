class CreateDoubles < ActiveRecord::Migration
  def change
    create_table :doubles do |t|
      t.integer :competitior_a
      t.integer :competitor_b

      t.timestamps null: false
    end
  end
end
