class StoryBranch
  attr_reader :levels, :ids, :addresses

  def initialize(story:, address:)
    set_levels_and_ids(story, address || "")
  end

  private

  def set_levels_and_ids(story, address)
    address_ids = [nil] + address.split(Story::ADDRESS_SEPARATOR)
    first_paragraph = story.first_paragraph
    current_level = [first_paragraph]
    @levels, @ids, @addresses = [], [], []
    loop do
      next_id = address_ids.pop
      chosen_paragraph = current_level.find { |par| par.id == next_id } ||
                         current_level.first
      chosen_id = chosen_paragraph.id
      @ids << chosen_id
      @addresses << current_level.map(&:address)
      @levels << current_level
      current_level = chosen_paragraph.next_paragraphs_sorted.to_a
      break if current_level.empty?
    end
  end
end