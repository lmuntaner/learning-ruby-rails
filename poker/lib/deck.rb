require_relative 'card.rb'

class Deck
  attr_accessor :cards
  SUITS = [:spade, :club, :heart, :diamond]
  def initialize
    @cards = []
    reset!
  end
  
  def count
    @cards.count
  end
  
  def deal(num)
    off_top = []
    num.times{ off_top << @cards.pop }
    off_top
  end
  
  def reset!
    @cards = []
    SUITS.each do |suit|
      (2..14).each do |value|
        card = Card.new(suit, value)
        @cards << card
      end
    end
  end
  
  def shuffle!
    @cards.shuffle!
  end
end

#this_deck = Deck.new
#p this_deck.cards
#p this_deck.deal(4)
#p this_deck.cards
#p this_deck.count