class Event < ActiveRecord::Base
  include Bootsy::Container
  extend SimpleCalendar
  has_calendar

  extend SaveDraftArchiveDelete


  has_one :address, as: :has_address
  accepts_nested_attributes_for :address

  has_many :attendances
  has_many :users, through: :attendances
  accepts_nested_attributes_for :users

  use_farm_slugs

  validates :start_time, presence: true

  mount_uploader :main_image, MainImageUploader, dependent: :destroy

  def djs_attending
    users.map{ |u| u.dj }
    # self.users.joins(:dj).where.not(:user_id => nil)
  end

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
