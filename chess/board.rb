require_relative "pieces"
require "byebug"

class Board
  attr_reader :rows, :sentinel
  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, sentinel) }
    if fill_board == true
      board_setup
    end
  end

  def board_setup
    fill_back_row(:blue)
    fill_back_row(:red)
    fill_front_row(:blue)
    fill_front_row(:red)
  end

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]
    i = color == :blue ? 7 : 0
    back_pieces.each_with_index do |class_name, j|
      class_name.new(color, self, [i, j])
    end
  end

  def fill_front_row(color)
    i = color == :blue ? 6 : 1
    8.times do |j|
      Pawn.new(color, self, [i,j])
    end
  end

  def [](pos)
    @rows[pos[0]][pos[1]]
  end

  def []=(pos, val)
    @rows[pos[0]][pos[1]] = val
  end

  def add_piece(piece, pos)
    raise 'position not empty' unless empty?(pos)

    self[pos] = piece
  end

  def empty?(pos)
    x, y = pos
    @rows[x][y] == @sentinel
  end

  def valid_pos?(pos)
    x, y = pos
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end

  # move without performing checks
  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise StandardError.new("cannot move here") unless piece.moves.include?(end_pos)
    self[end_pos] = piece
    self[start_pos] = @sentinel
    piece.position = end_pos
    nil
  end
  

  def move_piece(turn_color, start_pos, end_pos)
    raise 'start position is empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != turn_color
      raise 'You must move your own piece'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end

    move_piece!(start_pos, end_pos)
  end

  def possible_move_piece?(start_pos, end_pos)
    piece = self[start_pos]
   
    piece.moves.include?(end_pos)
  end

  def in_check?(color)
    king_position = king_pos(color)
    col = color == :blue ? :red : :blue 
    pieces = pieces(col)
  
    pieces.any? do |piece|
      pos = piece.position
     
      possible_move_piece?(pos, king_position)
    end
  end

  def checkmate?(color)
    pieces = pieces(color)
    valids_bol = pieces.none? {|piece| piece.valid_moves.empty?}
    valids_bol && in_check?(color)
  end

  def pieces(color)
    pieces = []
    8.times do |i|
      8.times do |j|
        pos = [i,j]
        if self[pos].color == color
          pieces << self[pos]
        end
      end
    end 
    pieces
  end

  def king_pos(color)
    8.times do |i|
      8.times do |j|
        pos = [i,j]
        if self[pos].is_a?(King) && self[pos].color == color
          return pos
        end
      end
    end 
  end

  def dup
    new_board = Board.new(false)
    pieces = pieces(:red) + pieces(:blue)
    pieces.each do |piece|
      # p "#{piece.class} + #{piece.position}"
      piece.class.new(piece.color, new_board, piece.position)
    end
    new_board
  end

end