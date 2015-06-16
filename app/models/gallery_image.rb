class GalleryImage < ActiveRecord::Base
  belongs_to :gallery

  validates :image, presence: true
  mount_uploader :image, GalleryImageUploader, dependent: :destroy
end
