class Knight
  def all_possible_moves(type,position)
  	arr_dimention = convert_position_to_coordinates(position)
  	possible_moves = []
  	x_pos = arr_dimention[0]
  	y_pos = arr_dimention[1]
  	if type.downcase == 'knight'
  		moveset = [
	      [-1, -2],
	      [-2, -1],
	      [-2, 1],
	      [-1, 2],
	      [1, -2],
	      [2, -1],
	      [2, 1],
	      [1, 2]
	    ]
	    moveset.each do |move|
	      x = x_pos + move[0]
	      y = y_pos + move[1]
	      if (0..7).include?(x) && (0..7).include?(y)
	        possible_moves << [x, y]
	      end
	    end
	  end
	  convert_coordinates_to_position(possible_moves)
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
end

Knight.new.all_possible_moves('knight','d2')
