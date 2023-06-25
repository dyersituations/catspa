class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.integer :page_type
      t.string :path
      t.string :banner
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
