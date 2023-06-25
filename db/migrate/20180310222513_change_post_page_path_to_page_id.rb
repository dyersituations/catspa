class ChangePostPagePathToPageId < ActiveRecord::Migration[5.2]
  def change
    # Add new page_id column and update based on page_path.
    add_column :posts, :page_id, :integer
    Post.all.each do |post|
      post.update_attributes(:page_id => Page.find_by_path(post.page_path).id)
    end
    remove_column :posts, :page_path
  end
end
