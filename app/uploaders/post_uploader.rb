class PostUploader < BaseUploader
  process :resize_to_fit => [650, 650]

  version :thumb do
    process :resize_to_fill => [360, 360, 'North']
  end
end
