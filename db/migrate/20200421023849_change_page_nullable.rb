class ChangePageNullable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :pages, :page_type, false, 0
    change_column_null :pages, :path, false, ""
    add_index :pages, :path, :unique => true
  end
end
