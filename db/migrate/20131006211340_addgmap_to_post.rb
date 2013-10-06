class AddgmapToPost < ActiveRecord::Migration
  def change
    add_column :posts, :gmaps, :boolean
  end
end
