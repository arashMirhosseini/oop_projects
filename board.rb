require_relative "tile"
require "byebug"

class Board
    def initialize
        @board = Array.new(10){Array.new(10)}
        randomized_bomb
        empty_cells
    end

    # randomly assign 10 bombs in the board. Mark them with 'B'
    def randomized_bomb
        rand_pos = random_pos
        row = rand_pos[0]
        col = rand_pos[1]
        10.times do |k|
            pos = [row[k], col[k]]
            if @board[row[k]][col[k]] == nil
                @board[row[k]][col[k]] = Tile.new(pos, 'B')
            end
            
        end
    end

    def random_pos
        row = []
        col = []
        while row.length != 10
            r = rand(0..9)
            if !row.include?(r)
                row << r
            end
        end
        while col.length != 10
            r = rand(0..9)
            if !col.include?(r)
                col << r
            end
        end
        [row, col]
    end

    def empty_cells
        10.times do |i|
            10.times do |j|
                
                if @board[i][j] == nil
                    @board[i][j] = Tile.new([i,j], '_')
                
                end
            end
        end
    end

    def [](pos)
        x, y = pos
        @board[x][y]
    end

    def []=(pos, new_content)
        x, y = pos
        @board[x][y] = Tile.new(pos,new_content)
    end

    def reveal_all
       
        10.times do |i|
            10.times do |j|
                # pos = [i,j]
                t = @board[i][j]
                t.reveal = true
            end
        end
    end

    def render
        puts (0..9).to_a.unshift(" ").join(" ")
        board.each_with_index do |row, i|
            print i
            row.each_with_index do |ele, j|
                if  ele.reveal
                    print " #{ele}"
                else
                    print " *"
                end
            end
            puts
        end

    end

    def render1
        puts (0..9).to_a.unshift(" ").join(" ")
        board.each_with_index do |row, i|
            print i
            row.each_with_index do |ele, j|
                print " #{ele}"
                # if  ele.reveal
                #     print " #{ele}"
                # else
                #     print " *"
                # end
            end
            puts
        end

    end

    def reveal_bomb_free_neighbors(pos)

        puts "pos= #{pos}"
        tile = self[pos]
        if !tile.bombed?
            tile.reveal = true
        end
        count = 0
        neighbors_ar = tile.neighbors(@board)
        neighbors_ar.each do |neighbor|
            if neighbor.bombed?
                count += 1
            end
        end
        puts "count: #{count}"
        if count > 0 
            return count 
        end
        neighbors_ar.each do |neighbor|
            if neighbor.reveal == false
                neighbor.reveal = true
                reveal_bomb_free_neighbors(neighbor.position)
            end
        end
        
        
    end



    attr_reader :board
end

 b = Board.new
 c = b
#  b.reveal_all
 b.render1
 b.reveal_bomb_free_neighbors([3,4])
 b.render
# p b.random_pos
