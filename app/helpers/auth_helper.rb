module AuthHelper
  def user_is_admin?
    user_signed_in? && current_user.admin
  end
end