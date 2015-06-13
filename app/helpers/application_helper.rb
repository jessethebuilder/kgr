module ApplicationHelper
  include FarmTools
  include FarmTools::ErrorsHelper
  include FarmTools::FacebookHelper
  include FarmTools::TwitterHelper

  include SaveDraftArchiveDeleteHelper

  def user_is_admin?
    true
  end

  def user_is_dj?
    user_signed_in? && !current_user.dj.nil?
  end

  def user_is_this_dj?(dj)
    user_signed_in? && current_user.dj == dj
  end
end
