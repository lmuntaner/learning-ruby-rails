class Hand
 
  def self.deal_from(deck)
    Hand.new(deck.take(8), deck)
  end

  attr_accessor :cards, :deck

  def initialize(cards, deck)
    @cards = cards
    @deck = deck
  end
  
  def [](index)
    @cards[index]
  end

  def draw
    @cards += deck.take(1)
  end
  
  def empty?
    @cards.empty?
  end

  def discard(pile, index)
    pile.discard(self[index])
    @cards.delete_at(index)
  end
  
  def can_play?(pile)
    return true if ( @cards.any? { |card| card.value == :eight } )
    @cards.any? do |card|
      card.value == pile.last_value || card.suit == pile.last_suit
    end
  end

  def to_s
    @cards.join(" | ")
  end
end
