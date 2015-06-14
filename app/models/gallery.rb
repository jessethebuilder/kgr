class Gallery < ActiveRecord::Base
  has_many :gallery_images
  accepts_nested_attributes_for :gallery_images

  use_farm_slugs
end
