class Show < ActiveRecord::Base
  belongs_to :dj

  # validates :name, presence: true
end
