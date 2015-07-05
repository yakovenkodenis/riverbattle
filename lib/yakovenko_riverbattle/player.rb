require_relative 'move'
require_relative 'field'
require_relative 'invalid_move_error'


=begin
	The class that represents the player
	of the game and contains the basic
	method that are used by both human player's
	and computers. Responsible for move validation
	and the game's field modification.
=end
class Player

	# :field - the actual game field of the player
	# :opponent_field_map - the auxiliary field object
	#    that helps the player to make moves. Represents the
	#    co-called imaginary opponent's field. This object is
	#    the one that is actually modified and rendered.
	# :moves - contains the array of the moves of the player.
	# :ships - contains the array of the ships of the player.
	attr_accessor :field, :opponent_field_map, :moves, :ships

	def initialize field
		@field = field
		@opponent_field_map = Field.new
		@moves = []
		@ships = []
	end

	# Adds the ship to the array of the ships and
	# raises the error if such move cannot be done
	# i.e. the ship has already been placed.
	def add_ship value
		raise InvalidMoveError if @ships.include?(value)
		@ships.push(value)
	end

	# Draws the imaginary opponent field 
	# on the console.
	def draw_opponent_field_map
		@opponent_field_map.draw
	end

	private

	# Validates the move in such a way that
	# in should be unique (for the efficiency) and
	# be in the range from 1 to 10.
	def validates_move move
		!@moves.include?(move) && move.index.between?(1,10)
	end

	# Modifies the imaginary field of the opponent
	# with a special symbol that represent either hit or miss
	# of the move made.
	def modify_opponent_field_map index, move
		hit = index == 10 ? "#{Symbols::HIT} " : Symbols::HIT
		miss = index == 10 ? "#{Symbols::MISS} " : Symbols::MISS
		@opponent_field_map[index] = move.hit ? hit : miss
	end

end