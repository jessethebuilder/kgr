class Show < ActiveRecord::Base
  extend SaveDraftArchiveDelete

  has_many :talent_fors
  has_many :users, through: :talent_fors

  use_farm_slugs

  mount_uploader :main_image, MainImageUploader
  mount_uploader :slider_image, SliderImageUploader

  def djs
    users.map{ |u| u.dj }
  end
end
