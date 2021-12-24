class StoriesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @stories = Story.all
  end
end
