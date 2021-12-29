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

  def new
    @story = Story.new
  end

  def create
    @story = Story.start(content: story_params[:content],
                         author: current_user)
    if @story.save
      redirect_to show_story_path(@story), success: "You've started a new story!"
    else
      render :new, status: :see_other
    end
  end

  private

  def story_params
    params.require(:story).permit(:content)
  end
end
