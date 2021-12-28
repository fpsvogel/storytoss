class StoriesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @stories = Story.all
  end

  def show
    story = Story.find(params[:id])
    @title = story.title
    @story_id = story.id
    @branch = StoryBranch.new(story: story,
                              address: params[:branch],
                              user: current_user)
  end
end
