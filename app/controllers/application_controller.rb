class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :require_login, except: [:not_authenticated]

  add_flash_types :success, :alert_lower

  protected

  def not_authenticated
    redirect_to login_path, notice: "Please log in first.", status: :see_other
  end
end
