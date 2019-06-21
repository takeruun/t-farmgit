class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :from, :string
    add_column :posts, :amount, :integer
    add_column :posts, :status, :string
    add_column :posts, :price, :integer
    add_column :posts, :postage, :string
  end
end
