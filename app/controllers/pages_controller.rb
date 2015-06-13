class PagesController < ApplicationController
  def home
    @calendar_events = Event.all
    @news_stories = NewsStory.published.limit(6)
  end

  def contact_us
  end
end
