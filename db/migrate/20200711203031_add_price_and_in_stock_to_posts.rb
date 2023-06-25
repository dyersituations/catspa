class AddPriceAndInStockToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :price, :decimal
    add_column :posts, :in_stock, :boolean
  end
end
