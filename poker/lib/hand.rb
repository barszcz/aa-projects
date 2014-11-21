require_relative 'deck'

class Hand

  HAND_SIZE = 5

  attr_reader :cards, :deck

  def initialize(cards = [], deck)
    @cards, @deck = cards, deck
  end

  def count
    @cards.size
  end

  def draw(deck)
    @cards += deck.take(HAND_SIZE - count)
  end

  # def discard(*indices)
  #   if indices.any? { |index| index > (HAND_SIZE - 1) }
  #     raise "Cannot discards card indices greater than 4"
  #   end
  #   @cards = @cards.reject.with_index { |card, index| indices.include?(index) }
  # end

  def discard(*indices)
    if indices.any? { |index| index > (HAND_SIZE - 1) }
      raise "Cannot discards card indices greater than 4"
    end
    indices.sort!.reverse!
    indices.each do |index|
      deck.return_to_deck([@cards[index]])
      @cards.delete_at(index)
    end
    p @cards
  end


  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    
  end

end
