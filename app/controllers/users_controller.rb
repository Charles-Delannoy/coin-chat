class UsersController < ApplicationController
  skip_before_action :check_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session['user_id'] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :status)
  end
end
