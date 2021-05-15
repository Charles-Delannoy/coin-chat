class ApplicationController < ActionController::Base
  before_action :current_user, :check_login

  def check_login
    redirect_to login_path unless @current_user
  end

  def current_user
    @current_user = session['user_id'] ? User.find(session['user_id'].to_i) : nil
  end
end
