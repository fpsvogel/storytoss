class ParagraphsController < ApplicationController
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
end
