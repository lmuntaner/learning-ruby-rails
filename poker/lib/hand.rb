require_relative 'card.rb'
require_relative 'hand_value.rb'

class Hand
  include HandValue
  attr_accessor :cards
  
  def initialize
    @cards = []
  end
  
  def [](index)
    @cards[index]
  end
  
  def discard(indexes)
    indexes.reverse!
    indexes.map { |index| @cards.delete_at(index) }
  end
  
  def draw(draw_cards)
    @cards += draw_cards
  end

  def count
    @cards.count
  end
  
  def in_hand?(card)
    @cards.include?(card)
  end
  
  def to_s
    @cards.join(" | ")
  end
end