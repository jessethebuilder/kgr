class Event < ActiveRecord::Base
  include Bootsy::Container

  validates :name, presence: true

  validates :start_time, presence: true

  serialize :djs_attending, Array

  mount_uploader :main_image, MainImageUploader
end
