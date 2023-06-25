class AddPageSubTypeToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :page_sub_type, :integer, :default => 0
  end
end
