class UsersController < ApplicationController
  def index
    @users = User.all.order(admin: :desc)
  end

  def update

  end

  private

  def set_user
    @user = params[:id]
  end

  def user_params
    params.require(:user).permit(:admin)
  end
end