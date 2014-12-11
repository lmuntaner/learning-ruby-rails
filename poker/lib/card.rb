require 'colorize'

class Card
  attr_accessor :suit, :value
  
  COLORS = { spade: :black, club: :green, heart: :red, diamond: :blue }
  SYMBOLS = {
    14 => "A",
    13 => "K",
    12 => "Q",
    11 => "J",
    10 => "10",
    9 => "9",
    8 => "8",
    7 => "7",
    6 => "6",
    5 => "5",
    4 => "4",
    3 => "3",
    2 => "2"
  }
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  
  def == other_card
    self.suit == other_card.suit && self.value == other_card.value
  end
  
  
  def to_s
    SYMBOLS[value].colorize(COLORS[suit])
  end
end