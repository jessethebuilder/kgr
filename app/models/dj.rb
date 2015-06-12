class Dj < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include Bootsy::Container

  belongs_to :user

  has_one :show
  accepts_nested_attributes_for :show

  after_initialize do
    build_show if show.nil?
  end

  use_farm_slugs

  validates :email, presence: true

  mount_uploader :head_shot, HeadShotUploader, dependent: :destroy

  before_save :find_or_build_user, on: :create

  #------------------ Methods ----------------------------

  def facebook_page
    /(https:\/\/)?www\.facebook\.com\/(.*)/ =~ facebook_url
    $2
  end

  private

  def find_or_build_user
    u = find_user || build_user
    self.user = u
  end

  def find_user
    User.where(:email => email).first
  end

  def build_user
    User.new(email: email, password: Random.rand(100000000..1000000000000000000).to_s)
  end
end
