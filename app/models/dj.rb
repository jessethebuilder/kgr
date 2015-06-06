class Dj < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include Bootsy::Container

  use_farm_slugs

  mount_uploader :head_shot, HeadShotUploader
end
