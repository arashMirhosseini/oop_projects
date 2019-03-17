
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = []
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    14.times do |i|
      cup = []
      4.times do |j|
        cup << :stone
      end
      if (i == 6) || (i == 13)
        @cups << []
      else
        @cups << cup
      end
    end
  end

  def valid_move?(start_pos)
    if !start_pos.between?(0,13)
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Starting cup is empty"
    end
    true
  end
  
  def make_move(start_pos, current_player_name)
    stones = []
    if valid_move?(start_pos)
      l = @cups[start_pos].length
      @cups[start_pos].delete(:stone)
      l.times {|i| stones << :stone}
      
      end_pos = dist_stones_curr_players(stones, start_pos, current_player_name)
      render
     
      next_turn(end_pos, current_player_name)
    
    end
  end

  def dist_stones_curr_players(stones, start, curr_player_name)
    i = start + 1
    if curr_player_name == @name1
      until stones.empty?
        @cups[i] << stones.shift unless i == 13
        j = i
        i += 1
        if i > 13
          i = 0
        end
      end
    else 
      until stones.empty?
        @cups[i] << stones.shift unless i == 6
        j = i
        i += 1
        if i > 13
          i = 0
        end
      end
    end
    j
  end

  def next_turn(ending_cup_idx, curr_player_name)
   
    @cups[ending_cup_idx].shift
   
    if @cups[ending_cup_idx].empty? && ending_cup_idx != 6 && ending_cup_idx != 13
    
      @cups[ending_cup_idx] << :stone
      return :switch
    end

    @cups[ending_cup_idx] << :stone
   
    if ending_cup_idx == 6 && curr_player_name == @name1
      
      return :prompt
    elsif ending_cup_idx == 13 && curr_player_name == @name2
    
      return :prompt
    else
     
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? {|cup| cup.empty?} || @cups[7..12].all? {|cup| cup.empty?}
  end

  def winner
    scores1 = @cups[6].length
    scores2 = @cups[13].length
    return :draw if scores1 == scores2
    name = scores1 > scores2 ? @name1 : @name2
    return name
    
  end
end
