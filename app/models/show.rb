class Show < ActiveRecord::Base
  extend SaveDraftArchiveDelete

  has_many :talent_fors
  has_many :users, through: :talent_fors

  use_farm_slugs
end
