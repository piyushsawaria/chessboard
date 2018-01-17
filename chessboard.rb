class ChessBoard
  def show_possible_moves(type,position)
    return puts 'Not a valid entry' unless is_valid_input?(type,position)
    arr_dimention = convert_position_to_coordinates(position)
    possible_moves = all_possible_moves(type,arr_dimention)
    p convert_coordinates_to_position(possible_moves)
  end

  def all_possible_moves(type,arr_dimention)
    possible_moves = []
    x_pos = arr_dimention[0]
    y_pos = arr_dimention[1]
    moveset = moveset(type)
    moveset.each do |move|
      x = x_pos + move[0]
      y = y_pos + move[1]
      if type.downcase == 'knight'
        if (0..7).include?(x) && (0..7).include?(y)
          possible_moves << [x, y]
        end
      else
        loop do
          break unless (0..7).include?(x) && (0..7).include?(y)
          possible_moves << [x, y]
          x += move[0]
          y += move[1]
        end
      end
    end
    possible_moves
  end

  def convert_position_to_coordinates(position)
    arr_pos = position.split('')
    x_row = {'a'=> 0, 'b'=> 1, 'c'=> 2, 'd'=> 3, 'e'=> 4, 'f'=> 5, 'g'=> 6, 'h'=> 7 }
    x_cord = x_row[arr_pos[0]]
    y_cord = arr_pos[1].to_i - 1
    [x_cord, y_cord]
  end

  def convert_coordinates_to_position(coordinates_arr)
    x_row = {0=>'a', 1=>'b', 2=>'c', 3=>'d', 4=>'e', 5=>'f', 6=>'g', 7=> 'h'}
    if coordinates_arr.all? { |e| e.class==Array }
      coordinates_arr.map do |ar|
        [x_row[ar[0]],ar[1]+1].join('')
      end.join(',')
    else
      [x_row[coordinates_arr[0]],coordinates_arr[1]+1].join('')
    end
  end

  def moveset(type)
    moveset = if type.downcase == 'rook'
      [
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
      ]
    elsif type.downcase == 'knight'
      [
        [-1, -2],
        [-2, -1],
        [-2, 1],
        [-1, 2],
        [1, -2],
        [2, -1],
        [2, 1],
        [1, 2]
      ]
    else
      [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
      ]
    end
  end

  def is_valid_input?(type,position)
    %w(knight queen rook).include?(type.downcase) &&
    ('a'..'h').map do |x|
      (1..8).map do |y|
        x+y.to_s
      end
    end.flatten.include?(position)
  end
end

class Node
  attr_accessor :type, :position, :possibilities, :previous
  def initialize(type,position, previous)
    @type = type
    @position = position
    @possibilities = ChessBoard.new.all_possible_moves(type, position)
    @previous = previous
  end
end

class ShortestPath < ChessBoard
  def piece_movement(type,pos1,target_pieces)
    return puts 'Not a valid entry' unless is_valid?(type,pos1,target_pieces)
    pos1 = convert_position_to_coordinates(pos1)
    pos2, pos2_text = find_longest_distance_piece(pos1,target_pieces)
    nodes = generate_nodes(type,pos1,pos2)
    arr_coordiantes = output(nodes)<<pos2
    puts "Number of steps required to reach #{pos2_text} is #{arr_coordiantes.count - 1}"
    p convert_coordinates_to_position(arr_coordiantes)
  end

  def find_longest_distance_piece(pos1,target_pieces)
    target_pieces_arr = target_pieces.split(',').map {|coordinate| convert_position_to_coordinates(coordinate) }
    hash_piece = Hash.new
    target_pieces_arr.each do |piece|
      hash_piece[piece] = Math.sqrt((piece[0] - pos1[0])**2 + (piece[1] - pos1[1])**2)
    end
    pos2_coordinate = hash_piece.key(hash_piece.values.sort.last)
    pos2_text = convert_coordinates_to_position(pos2_coordinate)
    return pos2_coordinate, pos2_text
  end
  
  def generate_nodes(type,pos1,pos2) 
    current = Node.new(type,pos1,nil)
    queue = []
    until current.possibilities.include?(pos2)
      for possible_move in current.possibilities
        queue<<Node.new(type,possible_move,current)
      end
      current = queue[0]
      queue = queue[1..-1]
    end
    current
  end
  
  def output(node)
    history = []
    until node == nil
      history.unshift(node.position)
      node = node.previous
    end
    history
  end

  def is_valid?(type, pos1, pos2_string)
    pos2_arr = pos2_string.split(',')
    if pos2_arr.count.between?(1,8)
      return pos2_arr.map{|pos| is_valid_input?(type,pos)}.all? && is_valid_input?(type,pos1)
    else
      return false
    end
  end
end

# ChessBoard.new.show_possible_moves('rook','a1')
# ShortestPath.new.piece_movement('queen','a1', 'b4,d2,a5,h4,h2,h8')
