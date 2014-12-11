require 'colorize'
require_relative 'piece'
require 'io/console'

class Board
  attr_accessor :grid, :pointer_pos, :current_seq
  attr_reader :current_color
  
  def initialize(current_color = :white)
    @grid = Array.new(8) { Array.new(8) }
    @current_color = current_color
    @pointer_pos = [0, 0]
    @current_seq = []
  end
  
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end  
  
  def change_turn!
    @current_color = ( @current_color == :white ? :black : :white)
  end
  
  def current_color?(color)
    @current_color == color
  end
  
  def deep_dup
    new_board = Board.new(current_color)
    
    pieces.each do |piece|
      pos_dup = piece.pos
      color_dup = piece.color
      new_board[pos_dup] = Piece.new(new_board, pos_dup, color_dup)
    end
    
    new_board
  end
    
  def display
    system("clear")
    @grid.each_with_index do |row, i1|
      row_str = []
      row.each_with_index do |el, i2|
        back = ((i1 + i2).even? ? :light_white : :white)
        back = :light_red if [i1, i2] == @pointer_pos
        row_str << (el.nil? ? "   " : el.to_s).colorize(:background => back)
      end
      puts row_str.join("")
    end
    puts "It's #{current_color} turn"
  end
  
  def draw?
    [:white, :black].any? do |color|
      pieces_of(color).all? { |piece| piece.total_moves.count == 0 }
    end
  end
  
  def finished?
    won? || draw?
  end
  
  def move(start_pos, end_pos)
    raise "No pieces in that position" if self[start_pos].nil?
    piece = self[start_pos]
    raise "That is not your piece!" unless current_color?(piece.color)
    raise "There is a piece in that end spot" unless self[end_pos].nil?
    
    piece.move(end_pos)
  end
  
  def move_cursor
    input = STDIN.getch
    
    case input
    when "a"
      @pointer_pos[1] -= 1
    when "d"
      @pointer_pos[1] += 1
    when "s"
      @pointer_pos[0] += 1
    when "w"
      @pointer_pos[0] -= 1
    when "o"
      @current_seq << pointer_pos.dup
    when "l"
      @current_seq << pointer_pos.dup
      perform_moves(@current_seq)
    when "e"
      exit
    end
  end

  def occupied?(position)
    !self[position].nil?
  end
    
  def on_board?(pos)
    pos.all? { |v| (0...8).include?(v) }
  end

  def perform_moves(sequence)
    if valid_move_seq?(sequence)
      perform_moves!(sequence)
    else
      raise "InvalidMoveError"
    end
  end
  
  def perform_moves!(sequence)
    total_moves = sequence.count - 1
    total_moves.times do |i|
      raise "No more than one move" if i == 1 && self[sequence[i]].not_jumping?
      start_pos = sequence[i]
      end_pos = sequence[i + 1]
      move(start_pos, end_pos)
      if i == (total_moves - 1) && self[sequence[i + 1]].more_jumps?
        raise "Still more jumps to do"
      end
    end

    change_turn!
    self[sequence[-1]].jumping = false
    @current_seq = []
  end
  
  def pieces
    @grid.flatten.compact
  end
  
  def pieces_of(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end
    
  def place_pieces
    self[[4, 3]] = Piece.new(self, [4, 3], :white)
    self[[3, 2]] = Piece.new(self, [3, 2], :black)
    self[[1, 2]] = Piece.new(self, [1, 2], :black)
    self[[1, 0]] = Piece.new(self, [1, 0], :black)
    self[[0, 3]] = Piece.new(self, [0, 3], :black)
  end
  
  def populate
    [0, 1, 2, 5, 6, 7].each do |row|
      color = (row < 4 ? :black : :white)
      @grid[row].count.times do |col|
        if (row + col).odd?
          self[[row, col]] = Piece.new(self, [row, col], color)
        end
      end
    end
  end

  def valid_move_seq?(sequence)
    dup_board = deep_dup
    begin
      raise "Not enough sequence!" if sequence.count <= 1
      dup_board.perform_moves!(sequence)
      true
    rescue => e
      puts e
      puts 'error caught in valid_move_seq'
      @current_seq = []
      false
    end
  end
  
  def winner
    @grid.flatten.compact.first.color if won?
  end
  
  def won?
    [:white, :black].any? { |color| pieces_of(color).count == 0 }
  end
end