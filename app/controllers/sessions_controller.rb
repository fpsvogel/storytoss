class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    if User.bot?(email: params[:email])
      flash.now[:alert_lower] = "You can't log in as a bot!"
      render :new, status: :see_other
      return
    end
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to stories_index_path, success: "Login successful."
    else
      flash.now[:alert_lower] = "Invalid email or password."
      render :new, status: :see_other
    end
  end

  def destroy
    logout
    redirect_to stories_index_path, notice: "Logged out.", status: :see_other
  end
end
