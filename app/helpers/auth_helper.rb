module AuthHelper
  def user_is_admin?
    user_signed_in? && current_user.admin
  end

  def authenticate_admin!
    unless user_is_admin?
      redirect_to failed_auth_redirect_path, :notice => "You must be an Administrator to view that page"
    end
  end

  private

  def failed_auth_redirect_path
    user_signed_in? ? root_path : new_user_session_path
  end
end