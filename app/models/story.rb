class Story < ApplicationRecord
  has_one :first_paragraph, class_name: "Paragraph"

  BRANCH_ID_SEPARATOR = "."

  def paragraph_at(branch_id)
    paragraph_ids = branch_id.split(BRANCH_ID_SEPARATOR)
    current_paragraph = first_paragraph
    paragraph_ids.each do |paragraph_id|
      current_paragraph = current_paragraph.continuations.find(paragraph_id)
    end
    current_paragraph
  end
end
