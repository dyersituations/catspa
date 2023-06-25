class AddPageOrderToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :page_order, :integer, :default => 0
  end
end
