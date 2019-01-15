require_relative "board"

class Tile
    
    def initialize(board, position)
        @board = board
        @position = position 
    end

    def bombed?
        x, y = @position
        return true if @board[x][y] == 'B'
        false
    end

    def flagged?
        x, y = @position
        return true if @board[x][y] == "F"
        false
    end

    def reveal?
        x, y = @position
        return true if @board[x][y] == '_'
        false
    end

    def neighbors
        i, j = @position
        neighbors_ar = []
        x = [-1, -1, -1, 0, 0, 1, 1, 1]
        y = [-1, 0, 1, -1, 1, -1, 0, 1]
        x.each_with_index do |num, k|
            neighbors_ar << Tile.new(board, [i+num, j+y[k]])
        end
        neighbors_ar
    end

    

    attr_reader :board, :position
end