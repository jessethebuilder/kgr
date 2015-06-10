class SliderPanel < ActiveRecord::Base
  belongs_to :slider_includeable, polymorphic: true

  mount_uploader :image, SliderImageUploader, dependent: :destroy
end

