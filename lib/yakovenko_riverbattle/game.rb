require_relative 'field'
require_relative 'human'
require_relative 'computer'
require_relative 'colorful'
require_relative 'constants'
require_relative 'exit_error'
require_relative 'victory_error'
require_relative 'invalid_move_error'

=begin
	This is the main class of the game that
	starts the game itself. To run the game
	use method `start`.
	The class deals with players' initialization,
	fields' rendering and manages players' moves.
=end
class Game

	# Include the special constants module
	# that contains  symbols for hits and mistakes 
	# player's moves and smiles for victory and defeat.
	include Symbols

	def initialize
		init_players
	end

	# Main method of the class. Starts the infinite
	# loop of the game. Constantly checks for user's
	# input and manages players' moves.
	def start
		message = get_instructions + "Enter which cell to shoot: ".cyan.bold
		message_norm = message
		message_arg_error = "Please, enter only numbers between 1 and 10".red.bold
		message_alert = message_arg_error + "\n" + message
		begin
			loop do
				draw_game_field
				print message
				message = message_norm
				cell = gets.chomp
				raise Exception if cell == 'q'
				cell = Integer(cell)
				raise ArgumentError unless cell.between?(1, 10)
				@human.move(cell, @computer.field)
				@computer.move(@human.field)
				draw_game_field
				check_victory
			end
		rescue ArgumentError => e
			message = message_alert
			puts message
			retry
		rescue VictoryError => e
			puts e.message
			exit 1
		rescue StandardError => e
			retry
		rescue Exception => e
			exit_the_game
		end
	end

	private

	# Checks for the victory of either of
	# players and raises the special VictoryError
	# that exits the game outputting the winner's
	# greeting.
	def check_victory
		my_hits = @human.opponent_field_map.moves_array.count { |x|
			!(x.to_s =~ /#{Symbols::HIT}/).nil?
		}
		my_ships = @human.field.moves_array.count { |x|
			!(x.to_s =~ /#{Symbols::SHIP}/).nil?
		}
		opponent_ships = @computer.field.moves_array.count { |x|
			!(x.to_s =~ /#{Symbols::SHIP}/).nil?
		}
		comp_hits = @computer.opponent_field_map.moves_array.count { |x|
			!(x.to_s =~ /#{Symbols::HIT}/).nil?
		}
		# check for the human victory
		raise VictoryError.new(@human) if my_hits == opponent_ships
		# check for the computer victory
		raise VictoryError.new(@computer) if comp_hits == my_ships
	end

	# Creates the objects of both players.
	# Initiates the game field for both of them.
	def init_players
		@human = Human.new("Jack", Field.new)
		@computer = Computer.new(Field.new)
		init_fields
	end

	# Initiates the game fields for the two
	# players separately and places the ships
	# of each player on their game field.
	def init_fields
		init_human_field
		init_computer_field
		place_ships_on_the_field(@human.ships, @human.field)
		place_ships_on_the_field(@computer.ships, @computer.field)
	end

	# Renders the three fields on the console:
	# the human player's field, the field of 
	# moves of the computer and the field of
	# the human player's moves.
	def draw_game_field
		system 'clear'
		puts "My field:".green.bold
		@human.field.draw
		puts "\nComputer's moves:".blue.bold
		@computer.draw_opponent_field_map
		puts "\nMy moves:".blue.bold
		@human.draw_opponent_field_map
	end

	# Asks the human player for how many
	# ships they're going to have (maximum 10).
	# The computer will have the same number of ships
	# generated randomly.
	def get_ships_number
		system 'clear'
		message = "Enter the number of your ships (10 max): ".green
		message_error = "You are allowed to enter only numbers between 1 and 10.\nPlease, try again.".red
		message_alert = message_error + "\n" + message
		begin
			print message
			@ships_number = gets.chomp
			raise ExitError if @ships_number == 'q'
			@ships_number = Integer(@ships_number)
			raise Exception unless @ships_number.between?(1, 10)
		rescue ExitError => e
			exit_the_game
		rescue Exception => e
			message = message_alert
			retry
		end
		puts "\rThe number of your ships will be #{@ships_number}".cyan
	end


	private

	# Returns the string of special
	# instructions and hints for the human
	# player.
	def get_instructions
		instructions = <<-TEXT
	Field symbols:
	#{Symbols::HIT} --> Hit
	#{Symbols::MISS} --> Miss
	#{Symbols::SHIP} --> Your ship

	Game control:
	q --> Exit

		TEXT
	end

	# After asking the human player
	# for the number of ships, the method
	# `init_human_field` is called. In a loop
	# it asks the player to choose which cell of
	# the field they want to place their ships to.
	# Validates the input.
	def init_human_field
		get_ships_number
		system 'clear'
		message = "Enter the number of the cell for your: ".green
		message_error = "You are allowed to enter only numbers between 1 and 10.\nPlease, try again.".red
		message_alert = message_error + "\n" + message
		i = 1
		begin
			message = "Enter the number of the cell for your #{i} ship (1-10): ".green
			print message
			input = gets.chomp
			raise ExitError if input == 'q'
			input = Integer(input)
			raise Exception unless input.between?(1, 10) && @human.add_ship(input)
			i += 1
		rescue ExitError => e
			exit_the_game
		rescue Exception => e
			puts "Enter only unique numbers between 1 and 10".red
			retry
		end until i == @ships_number + 1
	end

	# Allocates computer's ships randomly
	# based on the number of human player's ships
	def init_computer_field
		@computer.ships = (1..10).to_a.shuffle.take(@ships_number)
	end

	# Places the ships to the actual game field
	def place_ships_on_the_field ships, field
		ships.each do |ship|
			if ship.to_i == 10 then field[ship] = Symbols::SHIP + ' '
			else field[ship] = Symbols::SHIP
			end
		end
	end

	def exit_the_game
		abort ("\n Exiting the game...".magenta + "\n Have a nice day!\n".blue.bold)
	end
end