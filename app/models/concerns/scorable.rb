module Scorable
  def score
    calculated_score
  end

  def score_formatted
    sprintf("%+d", score)
  end

  def score_in_a_word
    if calculated_score > 0
      "positive"
    elsif calculated_score == 0
      "zero"
    else
      "negative"
    end
  end
end