class StoryBranch
  attr_reader :levels, :selected_paragraph_id, :reactions

  def initialize(story:, address:, user:)
    @levels = [[story.first_paragraph]]
    address_ids = (address || "").split(Story::ADDRESS_SEPARATOR)
    @selected_paragraph_id = Integer(address_ids.last) unless address_ids.empty?
    set_subsequent_levels(address_ids)
    set_reactions(user)
  end

  def paragraph_selected?
    !selected_paragraph_id.nil?
  end

  private

  def set_subsequent_levels(address_ids)
    shown_paragraph = @levels.first.first
    loop do
      current_level = shown_paragraph.next_paragraphs_sorted.to_a
      break if current_level.empty?
      shown_id = address_ids.shift
      shown_paragraph = find_shown_paragraph(current_level, shown_id)
      shift_shown_paragraph_first(current_level, shown_paragraph)
      @levels << current_level
    end
  end

  def find_shown_paragraph(current_level, shown_id)
    shown_paragraph = if shown_id.nil?
                        current_level.first
                      else
                        current_level.find { |par| par.id == Integer(shown_id) }
                      end
    raise ArgumentError if shown_paragraph.nil?
    shown_paragraph
  end

  def shift_shown_paragraph_first(current_level, shown_paragraph)
    current_level.delete(shown_paragraph)
    current_level.unshift(shown_paragraph)
  end

  def set_reactions(user)
    @reactions = @levels.map do |paragraphs|
      paragraphs.first.reaction_symbol(user: user)
    end
  end
end