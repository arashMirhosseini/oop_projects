require_relative "slidingPiece"
require_relative "piece"
require "colorize"

class Rook < Piece
  include SlidingPiece

  def symbol
    '♜'.colorize(color)
  end

  def move_dirs
    [[-1, 0], [1, 0], [0, -1], [0, 1]]
  end
  
end