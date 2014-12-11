require_relative 'hand.rb'

class Player
  attr_accessor :hand, :stack, :last_bet, :name
  
  def initialize(name, stack)
    @name, @stack = name, stack
    @hand = Hand.new
    @last_bet = nil
  end
   
  def ask_discard
    puts hand
    print "What cards do you want to discard? "
    discard_indexes = gets.chomp.split(' ').map(&:to_i)
    hand.discard(discard_indexes)
    discard_indexes.count
  end

  def draw_cards(cards)
    hand.draw(cards)
  end
  
  def reset_bet
    @last_bet = nil
  end
  
  def turn(amount)
    puts hand
    print "The bet to you is at #{amount}, what do you want to do? "
    player_input = gets.chomp
    case player_input
    when "c"
      @stack -= amount
      @last_bet = amount
      action = [:call, amount]
    when "f"
      action = [:fold, 0]
    else
      array_input = player_input.split(' ')
      @last_bet = array_input[1].to_i
      @stack -= last_bet
      action = [:raise, last_bet]
    end
    action
  end
  
  def win_pot(amount)
    @stack += amount
  end
end