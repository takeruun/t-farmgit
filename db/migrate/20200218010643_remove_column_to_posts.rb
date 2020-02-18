class RemoveColumnToPosts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :posts, :amount, :integer
  end
end
