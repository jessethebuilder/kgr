class PagesController < ApplicationController
  def home
    @calendar_events = Event.all
    @news_stories = NewsStory.published.limit(4).order('updated_at DESC')
    @show_more_stories_link = NewsStory.count > 4
  end

  def contact_us
  end
end
