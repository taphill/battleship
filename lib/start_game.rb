class StartGame
  def initialize(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @cpu_submarine = Ship.new('Submarine', 2)
  end

  def start
  #  intro
  #  user_ready?
    comp_ship_placement
    cpu_board.board_render(true)
    player_ship_placement
    player_board.board_render(true)
  #display_board
    turn
    who_won_game?
  end

  private

  attr_reader :cpu_board, :player_board, :player_cruiser, :player_submarine, :cpu_cruiser, :cpu_submarine

  def intro
    puts "\nWelcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit."
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
#    cpu_cruiser = Ship.new('Cruiser', 3)
#    cpu_submarine = Ship.new('Submarine', 2)

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

#    player_cruiser = Ship.new('Cruiser', 3)
#    player_submarine = Ship.new('Submarine', 2)

    puts 'Enter the squares for the Cruiser (3 spaces):'
    user_input = gets.chomp

    until player_board.valid_placement?(player_cruiser, user_input.split)
      puts 'Sorry, those are invalid coordinates. Please try again:'
      user_input = gets.chomp
    end

    player_board.place(player_cruiser, user_input.split)

    puts 'Enter the squares for the Submarine (2 spaces):'
    user_input = gets.chomp

    until player_board.valid_placement?(player_submarine, user_input.split)
      puts 'Sorry, those are invalid coordinates. Please try again:'
      user_input = gets.chomp
    end

    player_board.place(player_submarine, user_input.split)
  end

  def player_ship_placement_prompt
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The Cruiser is three units long and the Submarine is two units long.'
    puts '  1 2 3 4'
    puts 'A . . . .'
    puts 'B . . . .'
    puts 'C . . . .'
    puts 'D . . . .'
  end

  def turn
    until won?
      puts "\nEnter the coordinate for your shot:"

      user_input = gets.chomp
      until cpu_board.valid_coordinate?(user_input)
        if cpu_board.cell_fired_at?(user_input)
          puts "You've already fired at this coordinate....please enter a new one:"
          user_input = gets.chomp
        else
          puts "Please enter a valid coordinate:"
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
    display_board

  end

  def display_board
    puts "=============COMPUTER BOARD============="
    cpu_board.board_render

    puts"==============PLAYER BOARD=============="
    player_board.board_render(true)
  end

  def won?
    (player_cruiser.sunk? && player_submarine.sunk?) || (cpu_cruiser.sunk? && cpu_submarine.sunk?)
  end

  def player_results?(coordinate)
    if cpu_board.cells[coordinate].render == "X"
      puts "\nYour shot on #{coordinate} sunk a ship!"
    elsif cpu_board.cells[coordinate].render == "M"
      puts "\nYour shot on #{coordinate} was a miss."
    elsif cpu_board.cells[coordinate].render == "H"
      puts "\nYour shot on #{coordinate} was a hit!"
    else
      nil
    end
  end

  def cpu_results?(coordinate)
    if player_board.cells[coordinate].render == "X"
      puts "My shot on #{coordinate} sunk a ship!\n"
    elsif player_board.cells[coordinate].render == "M"
      puts "My shot on #{coordinate} was a miss.\n"
    elsif player_board.cells[coordinate].render == "H"
      puts "My shot on #{coordinate} was a hit!\n"
    else
      nil
    end
  end

  def who_won_game?
    if (player_cruiser.sunk? && player_submarine.sunk?)
      puts "I won!"
    elsif (cpu_cruiser.sunk? && cpu_submarine.sunk?)
      puts "You won!"
    else
      puts "Uh oh, something went wrong!"
    end 
  end


end
