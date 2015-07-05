require './human'
require './colorful'
require './computer'
require './constants'

=begin
	The specially created error that
	is raised when someone's victory 
	takes place. Receives the object of
	the winner as an input parameter. 
	Contains the special message for the victory.
=end
class VictoryError < StandardError

	# Include the special constants module
	# that contains  symbols for hits and mistakes 
	# player's moves and smiles for victory and defeat.
	include Symbols

	def initialize(winner)
		@winner = winner
	end

	# Generates the special greeting message
	# for the winner of the game,
	def message
		if(@winner.is_a? Computer)
			loose = (Symbols::LOOSE + ' ') * 3
			@message = <<-TEXT
			     #{'Computer wins!'.bold.blue}
			#{(loose + 'You loose...' + loose).bold.magenta}\n
			TEXT
		elsif(@winner.is_a? Human)
			win = (Symbols::WIN + ' ') * 3
			@message = <<-TEXT
			   #{'Computer sucks!'.bold.magenta}
			#{(win + 'You win!' + win).bold.cyan}\n
			TEXT
		end
		@message
	end

end