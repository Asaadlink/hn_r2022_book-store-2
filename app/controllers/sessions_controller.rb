class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase

    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = t "invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
