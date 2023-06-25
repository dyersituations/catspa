class CreateEditorImages < ActiveRecord::Migration[5.2]
  def change
    create_table :editor_images do |t|
      t.string :file
      t.string :alt
      t.timestamps
    end
  end
end
