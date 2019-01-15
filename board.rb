
class Board
    def initialize
        @board = Array.new(9){Array.new(9)}
    end

    # randomly assign 10 bombs in the board. Mark them with 'B'
    def randomized_bomb(board)
        10.times do 
            row = rand(0..9)
            column = rand(0..9)
            @board[row][column] = 'B'
        end
    end

    attr_reader :board
end