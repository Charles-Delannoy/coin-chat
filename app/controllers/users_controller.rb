class UsersController < ApplicationController
  skip_before_action :check_login

  def new
    redirect_to root_path if @current_user
    @user = User.new
  end

  def create
    if params[:shuffle]
      @user = User.new(nickname: Faker::Internet.user_name, status: 'Available')
    else
      @user = User.new(user_params)
    end
    if @user.save
      ActionCable.server.broadcast('users', { users: User.order(nickname: :asc) })
      session['user_id'] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.status = user_params[:status]
    @user.save
    ActionCable.server.broadcast('users', { users: User.order(nickname: :asc) })
  end

  def destroy
    @current_user.destroy
    reset_session
    redirect_to login_path
    ActionCable.server.broadcast('users', { users: User.order(nickname: :asc) })
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :status)
  end
end
