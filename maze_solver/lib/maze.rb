require "byebug"
class Maze

    attr_reader :maze, :current_position, :visited, :nodes, :parents

    def initialize
        welcome
        @maze = read_file
        @starting_point = start_position
        @current_position = [@starting_point[0],@starting_point[1]]
        @num_row = @maze.length 
        @num_column = @maze[0].length
        @visited = Array.new(@num_row){Array.new(@num_column){false}}
        @que_row = []
        @que_column = []
        @parents = Array.new(@num_row*@num_column){nil}
        @nodes = Array.new(@num_row){Array.new(@num_column)}
        n = -1
        @num_row.times do |i|
            @num_column.times do |j|
                @nodes[i][j] = n + 1
                n += 1
            end
        end
        @end =false
        
        run
    end



    # breadth first search travesal 
    def bfs(row, colunm)
        @que_row << row
        @que_column << colunm

        @visited[row][colunm] = true


        while !@que_row.empty?
            # remove the node from queue
            # byebug
            r = @que_row.shift
            c = @que_column.shift
            # if @maze[r][c] == "E" 
            #     break 
            #     return true
            # end

            # add it's children to the queue
            add_neighbors_que(r,c)

            # mark it as visited
            @visited[r][c] = true
        end
        return false
        
    end

    # adding the children or neighbor of a node
    def add_neighbors_que(row, column)
        dr = [-1, 1, 0, 0]
        dc = [0, 0, 1, -1]

        4.times do |i|
            new_c = dc[i] + column
            new_r = dr[i] + row
            
            next if @maze[new_r][new_c] == "*" || @maze[new_r][new_c] == "X"


            next if new_c < 0 || new_r < 0
            next if new_c >= @num_column || new_r >= @num_row
            next if @visited[new_r][new_c] == true
            @que_column << new_c
            @que_row << new_r

            # set the parent
            @parents[@nodes[new_r][new_c]] = @nodes[row][column]
           

        end
    end

    def path_finder
        start = @nodes[@starting_point[0]][@starting_point[1]]
        end_p = @nodes[end_position[0]][end_position[1]]
        init_node = end_p
        path = []
        while init_node != start
            path << @parents[init_node]
            init_node = @parents[init_node]

        end
        path.reverse.drop(1)
    end

    def mark_path_on_maze
        nodes = path_finder
        nodes.each do |node|
            xy = find_coordinate(node)
            @maze[xy[0]][xy[1]] = "X"
        end
        
    end

    def find_coordinate(node)
       
        @nodes.each_with_index do |row, i|
            row.each_with_index do |ele, j|
                if ele == node
                    return [i, j]
                end
            end
        end
    end
    
    
    def welcome
        puts "Please enter the name of the file for your maze: "
    end

    def run
        puts "This is your maze: "
        print_maze
        starting_point = start_position
        b = bfs(start_position[0], start_position[1])
        mark_path_on_maze
        print_maze
    end

    def read_file
        file_name = gets.chomp 
        file = File.open(file_name)
        lines = file.readlines(chomp: true)
        file.close
        return lines 
    end

    def print_maze
        @maze.each do |row|
            row.each_char do |ele|
                print ele 
            end
            puts
        end

    end

    def search_maze(find_element)
        @maze.each_with_index do |row, i|
            row.each_char.with_index do |ele, j|
                if ele == find_element
                    return [i,j]
                end
            end
        end
        return []
        
    end
    
    def start_position
        position = search_maze("S")
    end

    def end_position
        position = search_maze("E")
    end
    
    def find_route
        
    end

end

if __FILE__ == $PROGRAM_NAME
    maze = Maze.new()
    # p maze.end_position
    # p maze.visited[1][14]
    # p maze.nodes[1][14]
    # p maze.parents[30]
    # p maze.parents[29]
    # p maze.parents[28]
    # p maze.parents[44]
    # # p maze.nodes
    # # p maze.parents
    # p maze.path_finder
    # p maze.start_position
    # p maze.nodes[6][1]
end