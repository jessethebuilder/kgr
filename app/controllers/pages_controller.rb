class PagesController < ApplicationController
  def home
    @calendar_events = Event.all
    @news_stories = NewsStory.published
  end

  def contact_us
  end
end
