class RenameCommentToPosts < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :comment, :a_word
  end
end
