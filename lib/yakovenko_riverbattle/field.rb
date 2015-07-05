require './colorful'
require './move'
require './invalid_move_error'

=begin
	Represents the game field object.
	Contains specialized methods for rendering
	the field and receiving the player's moves.
=end
class Field

	# Two-dimensional array that
	# represents the actual game field
	# as it appears on the console screen.
	attr_reader :field

	def initialize
		@field = [[' ', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 
				  ['a',' ',' ',' ',' ',' ',' ',' ',' ',' ','  ']]
	end

	# Draws the game field on the console
	# using cyan background color.
	def draw
		field.each do |arr|
			arr.each { |i| print " #{i}     ".black.bg_cyan }
			puts
		end
	end

	# Returns the array that
	# consists of all the moves that
	# the current game field received.
	def moves_array
		@field[1]
	end

	# Checks if the `index` parameter, 
	# that represents the number of the cell
	# on the game field to shoot, actually
	# hits the ship. Returns the `Move` object.
	def receive_move index
		hit = !(@field[1][index] =~ /X/).nil?
		Move.new(index, hit)
	end

	# Setter created for the convenience
	# of the class usage.
	def []=(index, value)
		@field[1][index] = value
	end

	def [](index)
		@field[1][index]
	end

end

