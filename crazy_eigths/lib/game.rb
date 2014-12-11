require_relative 'deck'
require_relative 'discard'
require_relative 'hand'
require_relative 'player'
require 'colorize'
require 'faker'

class Game
  attr_accessor :players, :deck, :discard_pile
  
  def initialize(num_players)
    test_cards = [Card.new(:spades, :ace), Card.new(:hearts, :king), Card.new(:spades, :jack),
             Card.new(:diamonds, :four), Card.new(:clubs, :ten), Card.new(:spades, :five),
             Card.new(:diamonds, :five), Card.new(:clubs, :nine), Card.new(:spades, :six)]
    @deck = Deck.new()
    @players = Array.new (num_players) { Player.new(Faker::Name.name) }
        
    deck.shuffle
    deal
  end
  
  def deal
    @players.each do |player|
      player.hand = Hand.deal_from(deck)
    end
    
    @discard_pile = DiscardPile.deal_from(deck)
  end
  
  def game_over?
    @players.any? { |player| player.won? }
  end
  
  def play
    until game_over?
      players.each do |player|
        begin
          puts discard_pile
          player.print_hand
          player.play_turn(discard_pile, deck)
        rescue RuntimeError => e
          puts e.message
          next if e.message == "Empty deck"
          retry
        end
        break if player.won?
      end
    end
    puts "Game finished! #{winner.name}"
  end
  
  def winner
    players.select { |player| player.won? }.first
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new(2).play
end