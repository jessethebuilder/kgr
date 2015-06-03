class Dj < ActiveRecord::Base
  include Bootsy::Container

  use_farm_slugs
end
