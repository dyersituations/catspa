class ChangePostInStockToQuantity < ActiveRecord::Migration[5.2]
  def change
    # Add quantity and set based on in_stock.
    add_column :posts, :quantity, :integer, :default => 0
    Post.all.each do |post|
      post.update_attributes(:quantity => post.in_stock ? 1 : 0)
    end
    remove_column :posts, :in_stock
  end
end
