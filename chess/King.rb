require_relative "piece"
require_relative "steppingPiece"
require "colorize"

class King < Piece
  include SteppingPiece

  def symbol
    '♔'.colorize(color)
  end

  def move_diffs
    [
      [-1,-1], [-1,0], [-1, 1],
      [0,-1], [0, 1],
      [1,-1], [1, 0], [1, 1]
    ]
  end
  
end