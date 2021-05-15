class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user = session['user_id'] ? User.find(session['user_id'].to_i) : nil
  end
end
