class ChessBoard
  def all_possible_moves(type,position)
    return puts 'Not a valid entry' unless is_valide_input?(type,position)
    arr_dimention = convert_position_to_coordinates(position)
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
    p convert_coordinates_to_position(possible_moves)
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
    coordinates_arr.map do |ar|
      [x_row[ar[0]],ar[1]+1].join('')
    end.join(',')
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

  def is_valide_input?(type,position)
    %w(knight queen rook).include?(type.downcase) &&
    ('a'..'h').map do |x|
      (1..8).map do |y|
        x+y.to_s
      end
    end.flatten.include?(position)
  end

end

ChessBoard.new.all_possible_moves('knight','d2')
