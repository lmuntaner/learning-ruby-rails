require_relative 'card'

class DiscardPile
  attr_accessor :wild_card, :pile
  
  def self.deal_from(deck)
    DiscardPile.new(deck.take(1))
  end

  def initialize(cards)
    @pile = cards
    @wild_card = nil
  end
  
  def ask_suit
    @wild_card = nil
    until Card::suits.include?(wild_card)
      print "You discarded a crazy eight! Choose a suit: "
      @wild_card = gets.chomp.to_sym
    end
    p wild_card.inspect
    p wild_card.class
  end
  
  def count
    pile.count
  end
  
  def last_card
    @pile.last
  end
  
  def last_value
    last_card.value
  end
  
  def last_suit
    if wild_card.nil?
      @pile.last.suit
    else
      wild_card
    end
  end
  
  def discard(card)
    unless is_playable?(card)
      raise "must play #{last_suit}, #{last_value}, or a crazy 8!"
    end
    if card.value == :eight
      ask_suit
    else
      @wild_card = nil
    end
    p @pile << card
  end
  
  def is_playable?(card)
    val = card.value
    suit = card.suit
    val == :eight || val == last_value || suit == last_suit
  end
  
  def return_cards(deck)
    deck.return(@pile.shift(count - 1))
  end
  
  def to_s
    "Current card: #{wild_card.nil? ? last_card.to_s : wild_card.to_s}"
  end
end

d = DiscardPile.new([Card.new(:hearts, :nine)])
d.discard(Card.new(:spades, :nine))

