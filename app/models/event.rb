class Event < ActiveRecord::Base
  include Bootsy::Container
  extend SimpleCalendar
  has_calendar

  has_one :address, as: :has_address
  accepts_nested_attributes_for :address

  use_farm_slugs

  validates :start_time, presence: true

  serialize :djs_attending, Array

  mount_uploader :main_image, MainImageUploader, dependent: :destroy

  after_initialize do
    build_address if address.nil?
  end

  before_save do
    address.geocode
  end

  def starts_at
    start_time
  end
end
