class Event < ActiveRecord::Base
  include Bootsy::Container

  validates :name, presence: true

  validates :start_time, presence: true

  serialize :djs_attending, Array


end
