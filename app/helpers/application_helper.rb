module ApplicationHelper
  include FarmTools
  include FarmTools::ErrorsHelper
  include FarmTools::FacebookHelper

  include SaveDraftArchiveDeleteHelper

  def user_is_admin?
    true
  end

end
