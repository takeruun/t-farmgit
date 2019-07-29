class ChangeColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :posts, :rec, :boolean
  	add_column :posts, :fav_count, :integer
  	add_column :posts, :category, :string
  end
end
