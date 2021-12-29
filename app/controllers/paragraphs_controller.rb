class ParagraphsController < ApplicationController
  def new
    previous = Paragraph.find(params[:id])
    @new_paragraph = Paragraph.new
    render partial: "stories/paragraph",
           locals: { paragraph: previous,
                     selected_paragraph_id: nil,
                     reaction: previous.reaction_symbol(user: current_user),
                     edit_mode: true }
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
        render partial: "stories/paragraph",
              locals: { paragraph: previous,
                        selected_paragraph_id: nil,
                        reaction: previous.reaction_symbol(user: current_user),
                        edit_mode: true }
    end
  end

  def cancel_new
    previous = Paragraph.find(params[:id])
    render partial: "stories/paragraph",
            locals: { paragraph: previous,
                      selected_paragraph_id: nil,
                      reaction: previous.reaction_symbol(user: current_user),
                      edit_mode: false }
  end

  def like
    paragraph = Paragraph.find(params[:id])
    reaction_symbol = paragraph.toggle_like(user: current_user)
    render partial: "stories/paragraph_stats",
           locals: { paragraph: paragraph,
                     reaction: reaction_symbol }
  end

  def dislike
    paragraph = Paragraph.find(params[:id])
    reaction_symbol = paragraph.toggle_dislike(user: current_user)
    render partial: "stories/paragraph_stats",
           locals: { paragraph: paragraph,
                     reaction: reaction_symbol }
  end

  private

  def paragraph_params
    params.require(:paragraph).permit(:content)
  end
end
