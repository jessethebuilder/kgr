class PagesController < ApplicationController
  def home
    @calendar_events = Event.all
  end

  def contact_us
  end
end
