require_relative 'player'
require_relative 'constants'
require_relative 'invalid_move_error'

=begin
	Represents the Computer player
	of the game. Does random hits on
	the opponents field using the 
	initially generated array of random numbers. 
=end
class Computer < Player

	# Include the special constants module
	# that contains  symbols for hits and mistakes 
	# player's moves and smiles for victory and defeat.
	include Symbols

	def initialize field
		super field
		@moves = (1..10).to_a.shuffle.take(10)
		@move_count = 0
	end

	# Makes a move to the random 
	# cell of the opponent's field
	# `opponent_field` - the field object
	# of the opponent.
	def move opponent_field
		index = @moves[@move_count]
		move = opponent_field.receive_move(index)
		modify_opponent_field_map(index, move)
		@move_count += 1
		@moves << move
	end

end