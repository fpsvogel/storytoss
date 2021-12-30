module Scorable
  def score_formatted
    sprintf("%+d", score)
  end

  def score_in_a_word
    if score > 0
      "positive"
    elsif score == 0
      "zero"
    else
      "negative"
    end
  end
end