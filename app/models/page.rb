class Page < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  mount_uploader :banner, BannerUploader

  PAGE_TYPE = { :PLAIN => 0, :BLOG => 2, :GALLERY => 3 }
  PAGE_SUB_TYPE = { :SMALL_THUMBNAIL => 0, :LARGE_THUMBNAIL => 1 }
end
