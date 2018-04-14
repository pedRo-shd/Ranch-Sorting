class AddPriceToCompetitors < ActiveRecord::Migration
  def change
    add_column :competitors, :price, :decimal
  end
end
