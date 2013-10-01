class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.integer :user_id
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
