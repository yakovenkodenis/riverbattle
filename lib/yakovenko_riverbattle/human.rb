require './player'
require './constants'
require './invalid_move_error'

class Human < Player

	# Include the special constants module
	# that contains  symbols for hits and mistakes 
	# player's moves and smiles for victory and defeat.
	include Symbols

	def initialize name, field
		@name = name
		super field
	end

	# Makes a move on the opponent's field
	# and raises the error if the `index`
	# parameter is not a number in range from 1 to 10.
	# `opponent_field` - the field object of the opponent.
	def move index, opponent_field
		move = opponent_field.receive_move(index)
		raise InvalidMoveError unless (validates_move(move) && @moves << move)
		modify_opponent_field_map(index, move)
	end
end