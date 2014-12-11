# encoding: utf-8

class Piece
  attr_writer :king, :jumping
  attr_accessor :board, :pos, :color
  MOVE_DIRS = { black: [[1, 1], [1, -1]], white: [[-1, -1], [-1, 1]]}
  SYMBOLS = { black: " ◉ ", white: " ◎ ", }
  KINGS = { black: " ♚ ", white: " ♔ " }
      
  def initialize(board, pos, color)
    @pos = pos
    @board = board
    @color = color
    @king = false
    @jumping = false
  end
  
  def jumping?
    @jumping
  end
  
  def king?
    @king
  end
  
  def mandatory_jumping
    board.pieces_of(color).any? { |piece| piece.move_jumps.count >= 1} ? [] : move_diffs
  end
  
  def move(end_pos)
    sliding_moves = mandatory_jumping
    if sliding_moves.include?(end_pos)
      raise "No sliding after jumping!!" if jumping?
      perform_slide(end_pos)
    elsif move_jumps.include?(end_pos)
      perform_jump(end_pos)
    else
      raise "Invalid move"
    end
  end
  
  def move_diffs
    moves_sliding.select do |move|
       board.on_board?(move) && !board.occupied?(move)
    end
  end
  
  def move_dirs
    king? ? MOVE_DIRS.values.flatten(1) : MOVE_DIRS[color]
  end
  
  def move_jumps
    jumps = []
    move_dirs.each do |move|
      move1 = sum_pos(pos, move)
      next unless board.on_board?(move1)
      if board.occupied?(move1) && opponent?(move1, color)
        move2 = sum_pos(move1, move)
        next unless board.on_board?(move2)
        jumps << move2 unless board.occupied?(move2)
      end
    end
    jumps
  end
  
  def moves_sliding
    move_dirs.map do |move|
      sum_pos(pos, move)
    end
  end
  
  def not_jumping?
    !@jumping
  end
  
  def opponent?(position, color)
    raise "Opponner_method error" if board[position].nil?
    
    board[position].color != color
  end
  
  def perform_jump(end_pos)
    dx = (end_pos[0] - pos[0]) / 2
    dy = (end_pos[1] - pos[1]) / 2
    middle_pos = sum_pos(pos, [dx, dy])
    
    perform_move!(end_pos)
    board[middle_pos] = nil
    @jumping = true
    puts "jumping in perform_jump: #{@jumping}"
    
  end

  def perform_move!(end_pos)
    board[pos] = nil
    board[end_pos] = self
    @pos = end_pos
    @king = true if end_pos[0] == 0 && color == :white
    @king = true if end_pos[0] == 7 && color == :black
  end
  
  def perform_slide(end_pos)
    perform_move!(end_pos)
    @jumping = false
    puts "jumping in perform_slide: #{@jumping}"
  end
  
  def more_jumps?
    jumping? && move_jumps.count >= 1
  end
      
  def sum_pos(pos1, pos2)
    [(pos1[0] + pos2[0]), (pos1[1] + pos2[1])]
  end
  
  def to_s
    king? ? KINGS[color] : SYMBOLS[color]
  end
  
  def total_moves
    mandatory_jumping + move_jumps
  end
end