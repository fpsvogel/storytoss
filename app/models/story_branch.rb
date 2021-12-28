class StoryBranch
  attr_reader :levels, :ids, :branch_ids

  def initialize(story:, branch_id:)
    set_levels_and_ids(story, branch_id || "")
  end

  private

  def set_levels_and_ids(story, branch_id)
    branch_id_parts = [nil] + branch_id.split(Story::BRANCH_ID_SEPARATOR)
    first_paragraph = story.first_paragraph
    current_level = [first_paragraph]
    @levels, @ids, @branch_ids = [], [], []
    loop do
      next_id = branch_id_parts.pop
      chosen_paragraph = current_level.find { |par| par.id == next_id } ||
                         current_level.first
      chosen_id = chosen_paragraph.id
      @ids << chosen_id
      @branch_ids << current_level.map(&:branch_id)
      @levels << current_level
      current_level = chosen_paragraph.next_paragraphs_sorted.to_a
      break if current_level.empty?
    end
  end
end