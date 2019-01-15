require_relative "tile"

class Board
    def initialize
        @board = Array.new(10){Array.new(10)}
        randomized_bomb
    end

    # randomly assign 10 bombs in the board. Mark them with 'B'
    def randomized_bomb
        10.times do 
            row = rand(0..9)
            column = rand(0..9)
            pos = [row, column]
            @board[row][column] = Tile.new(pos, 'B')
        end
    end

    def render
        puts (0..9).to_a.unshift(" ").join(" ")
        board.each_with_index do |row, i|
            print i
            row.each_with_index do |ele, j|
                if ele != nil && ele.reveal?
                    print " #{ele}"
                else
                    print " *"
                end
            end
            puts
        end

    end



    attr_reader :board
end

b = Board.new
b.render
