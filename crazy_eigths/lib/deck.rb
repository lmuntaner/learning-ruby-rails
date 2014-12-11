require_relative 'card'

class Deck
  
  def self.all_cards
    deck = []
    Card::suits.each do |suit|
      Card::values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    
    deck
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end
  
  def count
    @cards.count
  end
  
  def empty?
    @cards.empty?
  end
  
  def take(n)
    raise "not enough cards" if count < n
    @cards.shift(n)
  end
  
  def return(cards)
    @cards += cards
    shuffle
  end
  
  def shuffle
    @cards.shuffle!
  end
end
