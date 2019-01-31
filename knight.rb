require_relative "steppingPiece"
require "colorize"
require_relative "piece"

class Knight < Piece
  include SteppingPiece

  def symbol
    '♘'.colorize(color)
  end

  def move_diffs
    [
      [-2,-1], [-2,1], [-1,-2], [-1,2],
      [1,-2], [1,2], [2,-1], [2, 1]
    ]
  end
  
end