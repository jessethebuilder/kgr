module ApplicationHelper
  include FarmTools
  include FarmTools::ErrorsHelper
  include FarmTools::FacebookHelper
  include FarmTools::TwitterHelper

  include SaveDraftArchiveDeleteHelper


  def user_is_dj?
    user_signed_in? && !current_user.dj.nil?
  end

  def user_is_this_dj?(dj)
    user_signed_in? && current_user.dj == dj
  end

  def recent_tweet_widget
    #todo
    '<a class="twitter-timeline" href="https://twitter.com/killergreenrad1" data-widget-id="609589667843805184">Tweets by @killergreenrad1</a>'.html_safe
  end

  def standard_image
    image_url('logos/radio_flag_large.png')
  end

  def standard_keywords
    ['marijuana', 'mmj']
  end

  def standard_slider_image_label
    "Slider Image <small>images should be 300 x 900</small>".html_safe
  end
end
