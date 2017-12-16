class AddCommentsCountToAd < ActiveRecord::Migration
  def change
    add_column :ads, :comments_count, :integer, default: 0
  end
end
