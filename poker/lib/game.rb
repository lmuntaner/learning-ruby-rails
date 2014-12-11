require_relative 'player.rb'
require_relative 'deck.rb'

class Game
  attr_accessor :players, :deck, :pot,
                :game_situation, :current_bet
  
  def initialize(*players)
    @players = players
    @deck = Deck.new
    @pot = 0
    @current_bet = 0
    @game_situation = Array.new(players.count) { true }
  end
  
  def deal_hands
    deck.shuffle!
    players.each do |player|
      player.hand.draw(deck.deal(5))
    end
  end

  def discard_cards
    players.each_with_index do |player, index|
      next if not_playing?(index)
      num_cards = player.ask_discard
      new_cards = deck.deal(num_cards)
      player.draw_cards(new_cards)
    end
  end
  
  def betting_round
    while true
      players.each_with_index do |player, index|
        next if not_playing?(index)
        return if last_player?(player)
        player_action = player.turn(current_bet)
        case player_action[0]
        when :fold
          @game_situation[index] = false
        when :call
          @pot += player_action[1]
        when :raise
          new_bet = player_action[1]
          @pot += new_bet
          @current_bet = new_bet
        end
      end
    end
  end
  
  def last_player?(player)
    return false if player.last_bet.nil?
    player.last_bet == current_bet
  end
  
  def play
    deal_hands
    betting_round
    if one_player?
      print_winner
      return
    end
    reset_bets
    puts "First round ended"
    discard_cards
    puts "Discarding round ended"
    betting_round
    if one_player?
      print_winner
    else
      show_hands
      print_winner
    end
  end

  def not_playing?(index)
    game_situation[index] == false
  end
  
  def print_winner
    winner = nil
    if one_player?
      winner_index = game_situation.index(true)
      winner = players[winner_index]
    else
      players.each do |player|
        winner = player if winner.nil?
        winner = player if winner.hand.get_value < player.hand.get_value
      end
    end
    
    puts "Congratulations #{winner.name}. You won #{pot}"
  end
  
  def one_player?
    game_situation.select { |situation| situation == true }.count == 1
  end
  
  def reset_bets
    @current_bet = 0
    players.each_with_index do |player, index|
      next if not_playing?(index)
      player.reset_bet
    end
  end
  
  def show_hands
    players.map { |player| puts "#{player.name} hand: #{player.hand}" }
  end
end

p1 = Player.new("Fante", 100)
p2 = Player.new("Bolano", 200)
p3 = Player.new("Travis", 300)

g = Game.new(p1, p2, p3)
g.play