class SliderPanel < ActiveRecord::Base
  belongs_to :slider_includeable, polymorphic: true
end

