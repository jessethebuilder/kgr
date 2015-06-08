class Dj < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include Bootsy::Container

  has_one :show
  accepts_nested_attributes_for :show

  after_initialize do
    build_show if show.nil?
  end

  use_farm_slugs

  mount_uploader :head_shot, HeadShotUploader
end
