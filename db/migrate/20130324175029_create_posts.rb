class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :page_path
      t.string :title
      t.string :image
      t.text :content
      t.string :category
      t.timestamps
    end
  end
end
