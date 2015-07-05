=begin
	Represents the move on the field.
	Created for being able to contain 
	the information about the accuracy of
	the player's move.
=end
class Move
	attr_reader :hit, :index

	def initialize index, hit
		@hit, @index = hit, index
	end
end