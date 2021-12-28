class StoriesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @stories = Story.all
  end

  def show
    story = Story.find(params[:id])
    @title = story.title
    @branch = StoryBranch.new(story: story, branch_id: nil)
  end
end
