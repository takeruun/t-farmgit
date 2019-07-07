class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :image_name
      t.string :comment
      t.boolean :rec
      t.string :from
      t.string :amount
      t.string :title

      t.timestamps
    end
  end
end
