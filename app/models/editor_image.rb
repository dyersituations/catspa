class EditorImage < ActiveRecord::Base
  mount_uploader :file, EditorImageUploader
end
