class StartGame
  def initialize(cpu_board, player_board)
    setup(cpu_board, player_board)
  end

  def start
    puts "\nWelcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit."
    user_ready?
  end

  private

  attr_reader :cpu_board, :player_board, :player_cruiser, :player_submarine, :cpu_cruiser, :cpu_submarine

  def setup(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @cpu_submarine = Ship.new('Submarine', 2)
  end

  def reset
    cpu_board = Board.new
    player_board = Board.new

    setup(cpu_board, player_board)
  end

  def user_ready?
    user_input = gets.chomp

    until user_input.downcase == 'p' || user_input.downcase == 'q'
      puts "Please enter 'p' to play or 'q' to quit."
      user_input = gets.chomp
    end

    return turn if user_input.downcase == 'p'
    return puts "\nGoodbye." if user_input.downcase == 'q'
  end

  def comp_ship_placement
    cruiser_coordinates = cpu_board.cells.keys.sample(3)
    until cpu_board.valid_placement?(cpu_cruiser, cruiser_coordinates)
      cruiser_coordinates = cpu_board.cells.keys.sample(3)
    end

    cpu_board.place(cpu_cruiser, cruiser_coordinates)

    submarine_coordinates = cpu_board.cells.keys.sample(2)
    until cpu_board.valid_placement?(cpu_submarine, submarine_coordinates)
      submarine_coordinates = cpu_board.cells.keys.sample(2)
    end

    cpu_board.place(cpu_submarine, submarine_coordinates)
  end

  def player_ship_placement
    player_ship_placement_prompt

    puts 'Enter the squares for the Cruiser (3 spaces):'
    user_input = gets.chomp

    until player_board.valid_placement?(player_cruiser, user_input.split)
      puts 'Sorry, those are invalid coordinates. Please try again:'
      user_input = gets.chomp
    end

    player_board.place(player_cruiser, user_input.split)
    puts "\n"

    puts 'Enter the squares for the Submarine (2 spaces):'
    user_input = gets.chomp

    until player_board.valid_placement?(player_submarine, user_input.split)
      puts 'Sorry, those are invalid coordinates. Please try again:'
      user_input = gets.chomp
    end

    player_board.place(player_submarine, user_input.split)

    puts "\n"
  end

  def board_size
    puts "You get to choose the size of the board."
    puts "\nThe minimum size is 4 x 4, and the maximum is 26 x 26."
    puts "\nWhat height do you want the board?"

    user_input = gets.chomp.to_i
    until user_input >= 4 && user_input <= 26
      puts "Sorry, that's not within the guidelines. Please try again:"
      user_input = gets.chomp.to_i
    end
    cpu_board.columns = user_input
    player_board.columns = user_input

    puts "\nAnd what width do you want the board?"
    user_input = gets.chomp.to_i
    until user_input >= 4 && user_input <= 26
      puts "Sorry, that's not within the guidelines. Please try again:"
      user_input = gets.chomp.to_i
    end
    cpu_board.rows = user_input
    player_board.rows = user_input

    cpu_board.create_cells
    player_board.create_cells
  end

  def player_ship_placement_prompt
    puts "\nI have laid out my ships on the grid."
    puts 'You now need to lay out your two ships.'
    puts 'The Cruiser is three units long and the Submarine is two units long.'
    puts "\n"
    player_board.board_render
  end

  def turn
    board_size
    comp_ship_placement
    player_ship_placement

    display_board

    until won?
      puts "\nEnter the coordinate for your shot:"

      user_input = gets.chomp
      until cpu_board.valid_coordinate?(user_input)
        if cpu_board.cell_fired_at?(user_input)
          puts "You've already fired at this coordinate....please enter a new one:"
          user_input = gets.chomp
        else
          puts 'Please enter a valid coordinate:'
          user_input = gets.chomp
        end
      end
      cpu_board.cells[user_input].fire_upon

      coordinate = player_board.cells.keys.sample
      until player_board.valid_coordinate?(coordinate)
        coordinate = player_board.cells.keys.sample
      end
      player_board.cells[coordinate].fire_upon

      display_board
      player_results?(user_input)
      cpu_results?(coordinate)
    end

    puts "\n"
    display_board
    who_won_game?
  end

  def display_board
    puts '=============COMPUTER BOARD============='
    cpu_board.board_render
    puts "\n"
    puts '==============PLAYER BOARD=============='
    player_board.board_render(true)
  end

  def won?
    (player_cruiser.sunk? && player_submarine.sunk?) || (cpu_cruiser.sunk? && cpu_submarine.sunk?)
  end

  def player_results?(coordinate)
    if cpu_board.cell_render(coordinate) == 'X'
      puts "\nYour shot on #{coordinate} sunk a ship!"
    elsif cpu_board.cell_render(coordinate) == 'M'
      puts "\nYour shot on #{coordinate} was a miss."
    elsif cpu_board.cell_render(coordinate) == 'H'
      puts "\nYour shot on #{coordinate} was a hit!"
    end
  end

  def cpu_results?(coordinate)
    if player_board.cell_render(coordinate) == 'X'
      puts "My shot on #{coordinate} sunk a ship!\n"
    elsif player_board.cell_render(coordinate) == 'M'
      puts "My shot on #{coordinate} was a miss.\n"
    elsif player_board.cell_render(coordinate) == 'H'
      puts "My shot on #{coordinate} was a hit!\n"
    end
  end

  def who_won_game?
    if player_cruiser.sunk? && player_submarine.sunk?
      puts "\n\nI won!"
    elsif cpu_cruiser.sunk? && cpu_submarine.sunk?
      puts "\n\nYou won!"
    else
      puts 'Uh oh, something went wrong!'
    end

    reset
    puts "\nWould you like to play again?\nEnter 'p' to play. Enter 'q' to quit."
    user_ready?
  end
end
