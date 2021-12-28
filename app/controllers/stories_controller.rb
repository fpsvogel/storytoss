class StoriesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @stories = Story.all
  end

  def show
    story = Story.find(params[:id])
    @title = story.title
    @branch = StoryBranch.new(story: story, address: nil)
  end
end
