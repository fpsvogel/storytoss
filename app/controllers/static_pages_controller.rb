class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:about]

  def about
  end
end
