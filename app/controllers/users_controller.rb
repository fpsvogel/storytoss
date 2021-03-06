class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to stories_index_path, success: "Registration successful."
    else
      render :new, status: :see_other
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:username,
                  :email,
                  :password,
                  :password_confirmation)
  end
end
