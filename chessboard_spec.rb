$LOAD_PATH << '.'
require 'chessboard'

describe 'chessboard' do
	context '#all_possible_moves' do
  	it 'return all possible cordinates from given cordinates' do
  		possiblities = ChessBoard.new.all_possible_moves('knight', [0,0])
  		expect(possiblities).to eq [[2,1], [1,2]]
  	end
  end

  context '#convert_position_to_coordinates' do    
    it 'return the cordinate of a given position' do 
      cordinate = ChessBoard.new.convert_position_to_coordinates('a1')
      expect(cordinate).to eq [0,0]
    end    
  end

  context '#convert_coordinates_to_position' do
  	it 'return the position from given array of cordinates' do
  		positions = ChessBoard.new.convert_coordinates_to_position([[0,0],[1,1],[2,2]])
  		expect(positions).to eq 'a1,b2,c3'
  	end
  end

  context '#show_possible_moves' do
  	it 'return possible moves in string' do
  		moves = ChessBoard.new.show_possible_moves('Knight', 'a1')
  		expect(moves).to eq 'c2,b3'
  	end
  end

  context '#moveset' do
  	it 'return array of first possible coordinates' do
  		possible_arr = ChessBoard.new.moveset('rook')
  		expect(possible_arr).to eq [[0, 1],[0, -1],[1, 0],[-1, 0]]
  	end
  end

  context '#is_valid_input?' do
  	it 'return true' do
  		val = ChessBoard.new.is_valid_input?('queen','d4')
  		expect(val).to eq true
  	end
  	it 'return false' do
  		val = ChessBoard.new.is_valid_input?('queen','d9')
  		expect(val).to eq false
  	end
  end
end

describe 'ShortestPath' do
	context '#find_longest_distance_piece' do
		it 'return target coordinates and position' do
			pos2_cor, pos2_text = ShortestPath.new.find_longest_distance_piece([0,0],'a1,h7,g5')
			expect(pos2_cor).to eq [7,6]
			expect(pos2_text).to eq 'h7'
		end
	end
	
	context '#piece_movement' do
		it 'shows the shortest route taken' do
			route = ShortestPath.new.piece_movement('knight','a1', 'b4,d2,a5,h4,h2,h8')
			expect(route).to eq 'a1,c2,a3,c4,e5,g6,h8'
		end
	end

	context '#is_valid?' do
  	it 'return true' do
  		val = ShortestPath.new.is_valid?('queen','a1', 'b4,d2,a5,h4,h2,h8')
  		expect(val).to eq true
  	end
  	it 'return false' do
  		val = ShortestPath.new.is_valid?('queen','a11', 'b4,d2,a5,h4,h2,h8')
  		expect(val).to eq false
  	end
  end
end
