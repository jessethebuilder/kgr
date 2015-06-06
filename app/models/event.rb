class Event < ActiveRecord::Base
  include Bootsy::Container
  extend SimpleCalendar
  has_calendar

  has_one :address, as: :has_address
  accepts_nested_attributes_for :address

  use_farm_slugs

  validates :start_time, presence: true

  serialize :djs_attending, Array

  mount_uploader :main_image, MainImageUploader

  def starts_at
    start_time
  end
end
