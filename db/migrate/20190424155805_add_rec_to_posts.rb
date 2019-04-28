class AddRecToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rec, :boolean
  end
end
