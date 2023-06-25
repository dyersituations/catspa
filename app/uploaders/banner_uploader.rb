class BannerUploader < BaseUploader
  process :resize_to_fill => [2400, 300]
end
