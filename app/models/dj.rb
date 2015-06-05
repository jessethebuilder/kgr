class Dj < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include Bootsy::Container

  use_farm_slugs

  validates :tag_line, presence: true

  mount_uploader :head_shot, HeadShotUploader
  mount_uploader :slider_image, SliderImageUploader
end
