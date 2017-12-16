class AddPriceCentsToAds < ActiveRecord::Migration
  def up
    add_column :ads, :price_cents, :integer, default: 0
  end

  def down
    remove_column :ads, :price_cents, :integer
  end
end
