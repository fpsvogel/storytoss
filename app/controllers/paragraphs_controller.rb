class ParagraphsController < ApplicationController
  def new
    @new_paragraph = Paragraph.new
    render_paragraph(edit_mode: true)
  end

  def create
    previous = Paragraph.find(params[:id])
    @new_paragraph = previous.add_next_paragraph(
                                content: paragraph_params[:content],
                                author: current_user)
    if @new_paragraph.save
      flash[:success] = "You've continued the story!"
      show_story_with_new_highlighted =
        show_story_path(@new_paragraph.story,
                        branch: @new_paragraph.address,
                        anchor: "p#{@new_paragraph.id}")
        redirect_to show_story_with_new_highlighted, status: :see_other
    else
      render_paragraph(previous: previous, edit_mode: true)
    end
  end

  def cancel_new
    render_paragraph(edit_mode: false)
  end

  def like
    toggle_reaction_and_render_stats(reaction: :like)
  end

  def dislike
    toggle_reaction_and_render_stats(reaction: :dislike)
  end

  private

  def paragraph_params
    params.require(:paragraph).permit(:content)
  end

  def render_paragraph(previous: Paragraph.find(params[:id]), edit_mode:)
    render partial: "stories/paragraph",
            locals: { paragraph: previous,
                      selected_paragraph_id: nil,
                      reaction: previous.reaction_symbol(user: current_user),
                      edit_mode: edit_mode }
  end

  def toggle_reaction_and_render_stats(reaction:)
    paragraph = Paragraph.find(params[:id])
    reaction_symbol = paragraph.send("toggle_#{reaction}", user: current_user)
    render partial: "stories/paragraph_stats",
           locals: { paragraph: paragraph,
                     reaction: reaction_symbol }
  end
end
