require_relative 'board'

class Game
  attr_reader :board, :error_message
  def initialize
    @board = Board.new
  end
  
  def new_game
    @board.populate
    run
  end
  
  def testing_game
    @board.place_pieces
    run
  end
  
  def run
    begin
      until board.finished?
        board.display
        puts @error_message
        @error_message = ""
        board.move_cursor
      end
    rescue RuntimeError => e
      @error_message = e.message
      retry
    end
    board.display
    if board.won?
      puts "congratulations #{board.winner} won!!"
    else
      puts "That's a draw!!!"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.new_game
end