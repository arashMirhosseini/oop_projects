# require_relative "board"
require "colorize"

class Tile
    
    def initialize(position, content = nil)
        # @board = board
        @position = position 
        @content = content
        @reveal = false
        @counter = 0
        @flag = false
    end

    def bombed?
        # x, y = pos
        return true if @content == 'B'
        false
    end

    def flagged?
        # x, y = pos
        return true if @content == "F"
        false
    end

    # def reveal?
    #     # x, y = pos
    #     return true if @content == '_'
    #     false
    # end

    def neighbors(board)
        i, j = position
        neighbors_ar = []
        x = [-1, -1, -1, 0, 0, 1, 1, 1]
        y = [-1, 0, 1, -1, 1, -1, 0, 1]
        x.each_with_index do |num, k|
            if valid_pos?(i+num, j+y[k])
                neighbors_ar << board[i+num][j+y[k]]
            end
        end
        neighbors_ar
    end

    def valid_pos?(i,j)
        i >= 0 && i <= 9 && j >=0 && j <= 9
    end

    def neighbor_bomb_count
        neigh = neighbors
        count = 0
        neigh.each do |neighbor|
            count += 1 if neighbor.bombed? 
        end
        count
    end

    def color
        content == 'B'? :red : :blue
    end

    def to_s
        if counter > 0 
            counter.to_s.colorize(:green)
        else
            content.colorize(color)
        end
    end


    attr_accessor :position, :content, :reveal, :counter, :flag
end

# t = Tile.new([0,0], 'B')
# puts t.bombed?