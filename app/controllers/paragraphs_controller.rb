class ParagraphsController < ApplicationController
  skip_before_action :require_login, only: [:new, :like, :dislike]

  def new
    create_mode = if logged_in?
                    @new_paragraph = Paragraph.new
                    true
                  else
                    flash.now[:alert_lower] = "Please log in first."
                    false
                  end
    render_paragraph(create_mode: create_mode)
  end

  def create
    previous = Paragraph.find(params[:id])
    @new_paragraph = previous.add_next_paragraph(
                                content: paragraph_params[:content],
                                author: current_user)
    if @new_paragraph.save
      show_story_with_new_highlighted =
        show_story_path(@new_paragraph.story,
                        branch: @new_paragraph.address)
        redirect_to show_story_with_new_highlighted,
                    success: "You've continued the story!",
                    status: :see_other
    else
      render_paragraph(paragraph: previous, create_mode: true)
    end
  end

  def cancel_new
    render_paragraph(create_mode: false)
  end

  def destroy
    paragraph = Paragraph.find(params[:id])
    story = paragraph.story
    if paragraph.next_paragraphs.count > 0
      redirect_to show_story_path(story),
                  alert: "You can't delete your paragraph because the story " \
                         "has already been continued from there.",
                  status: :see_other
    elsif paragraph.level == 1
      paragraph.story.destroy
      redirect_to stories_index_path,
                  notice: "You've deleted your story.",
                  status: :see_other
    else
      paragraph.destroy
      redirect_to show_story_path(story),
                  notice: "You've deleted your paragraph.",
                  status: :see_other
    end
  end

  def like
    toggle_reaction_and_render(reaction: :like)
  end

  def dislike
    toggle_reaction_and_render(reaction: :dislike)
  end

  private

  def paragraph_params
    params.require(:paragraph).permit(:content)
  end

  def render_paragraph(paragraph: Paragraph.find(params[:id]),
                       reaction: paragraph.reaction_symbol(user: current_user),
                       create_mode:)
    render partial: "stories/paragraph",
           locals: { paragraph: paragraph,
                      selected_paragraph_id: nil,
                      reaction: reaction,
                      create_mode: create_mode }
  end

  def toggle_reaction_and_render(reaction:)
    paragraph = Paragraph.find(params[:id])
    reaction_toggled =
      if logged_in?
        paragraph.send("toggle_#{reaction}", user: current_user)
      else
        flash.now[:alert_lower] = "Please log in first."
        nil
      end
    render_paragraph(paragraph: paragraph,
                     reaction: reaction_toggled,
                     create_mode: false)
  end
end
