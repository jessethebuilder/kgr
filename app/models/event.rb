class Event < ActiveRecord::Base
  include Bootsy::Container
  extend SimpleCalendar
  has_calendar

  validates :name, presence: true

  validates :start_time, presence: true

  serialize :djs_attending, Array

  mount_uploader :main_image, MainImageUploader

  def starts_at
    start_time
  end
end
