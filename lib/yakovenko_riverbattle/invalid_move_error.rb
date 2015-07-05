=begin
	The specially created error that is 
	raised when the wrong or improper
	move is done by the player.
=end
class InvalidMoveError < StandardError

	def initialize(msg = nil)
		@message = msg
	end

	def message
		"You cannot make that move. #{@message}"
	end
end