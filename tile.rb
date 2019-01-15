require_relative "board"

class Tile
    
    def initialize(board)
        @board = board
    end

    def bombed?(pos)
        x, y = pos
        return true if @board[x][y] == 'B'
        false
    end
    
end