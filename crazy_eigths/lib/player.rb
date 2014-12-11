class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = nil
  end
  
  def won?
    @hand.empty?
  end
  
  def play_turn(discard_pile, deck)
    until hand.can_play?(discard_pile) || deck.empty?
      puts "You had to draw a card!"
      hand.draw
      puts hand
    end
    if deck.empty?
      discard_pile.return_cards(deck)
      raise "Empty deck" unless hand.can_play?(discard_pile)
    end
    print "What card do you want to discard? "
    card_index = gets.chomp.to_i
    hand.discard(discard_pile, card_index)
  end
  
  def print_hand
    puts "#{name}, it's your turn, this is your hand:"
    puts hand
  end
end
