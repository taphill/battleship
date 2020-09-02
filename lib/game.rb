class Game
  attr_reader :cpu_board, :player_board, :cpu_ships, :player_ships
  def initialize(cpu_board, player_board)
    setup(cpu_board, player_board)
  end

  def setup(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @cpu_ships = []
    @player_ships = []
  end

  def reset
    cpu_board = Board.new
    player_board = Board.new

    setup(cpu_board, player_board)
  end

  def intro
    puts "\nWelcome to BATTLESHIP\n\nEnter 'p' to play. Enter 'q' to quit."
    print "> "
  end

  def user_ready?
    user_input = gets.chomp

    until user_input.downcase == 'p' || user_input.downcase == 'q'
      puts "Please enter 'p' to play or 'q' to quit."
      print "> "
      user_input = gets.chomp
    end

    return true if user_input.downcase == 'p'
    return false if user_input.downcase == 'q'
  end

  def goodbye
    puts "\nGoodbye"
  end

  def board_size
    puts "\nRULES OF THE GAME:"
    puts "\n  - You get to choose the size of the board, and the number, name and length of the ships you want."
    puts "  - The minimum board size is 4x4, and the maximum is 26x26."
    puts "  - The minimum ship size is 1 unit and the maximum is 4 units."
    puts "  - You may potentially create up to 6 ships in total."
    puts "  - If you choose a board size less than 6 rows OR 6 columns then you will only be allowed to use the default ships."
    puts "  - The default ships are the 3 unit Cruiser and 2 unit Submarine."
    puts "\nHow many rows do you want for the board?"
    print "> "

    user_input = gets.chomp.to_i
    until user_input >= 4 && user_input <= 26
      puts "Sorry, that's not within the guidelines. Please try again:"
      print "> "
      user_input = gets.chomp.to_i
    end

    cpu_board.rows = user_input
    player_board.rows = user_input

    puts "\nAnd how many columns do you want for the board?"
    print "> "

    user_input = gets.chomp.to_i
    until user_input >= 4 && user_input <= 26
      puts "Sorry, that's not within the guidelines. Please try again:"
      print "> "
      user_input = gets.chomp.to_i
    end

    cpu_board.columns = user_input
    player_board.columns = user_input

    cpu_board.create_cells
    player_board.create_cells
  end

  def create_ships
    if player_board.rows < 6 || player_board.columns < 6
      player_ships << Ship.new("Cruiser", 3)
      player_ships << Ship.new("Submarine", 2)
      cpu_ships << Ship.new("Cruiser", 3)
      cpu_ships << Ship.new("Submarine", 2)
      return puts "\nBased on your board size, the default ships will be used"
    end

    puts "\nOk...how many ships would you like?"
    print "> "
    user_input = gets.chomp.to_i

    until user_input >= 1 && user_input <= 6
      puts "\nPlease enter a number between 1 and 4"
      print "> "
      user_input = gets.chomp.to_i
    end

    loop_num = 0

    until user_input == player_ships.count
      loop_num += 1
      puts "\nEnter a name for ship ##{loop_num}"
      print "> "
      name = gets.chomp

      puts "\nEnter a size for ship ##{loop_num}. (min = 1, max = 4)"
      print "> "
      size = gets.chomp.to_i

      until size >= 1 && size <= 4
        puts "\nPlease enter a number between 1 and 4"
        print "> "
        size = gets.chomp.to_i
      end

      player_ships << Ship.new(name, size)
      cpu_ships << Ship.new(name, size)
    end
  end

  def comp_ship_placement
    cpu_ships.each do |ship|
      coordinates = cpu_board.cells.keys.sample(ship.length)

      until cpu_board.valid_placement?(ship, coordinates)
        coordinates = cpu_board.cells.keys.sample(ship.length)
      end

      cpu_board.place(ship, coordinates)
    end
  end

  def player_ship_placement_prompt
    puts "\nI have laid out my ships on the grid."
    puts 'You now need to lay out your ships.'
    puts 'Make sure there is a space between each coordinate otherwise it will be considered invalid.'
    puts "\n"
    player_board.board_render
  end

  def player_ship_placement
    player_ship_placement_prompt

    player_ships.each do |ship|
      puts "\nEnter the coordinates for the #{ship.name} ship which is #{ship.length} space(s) long:"
      print "> "
      user_input = gets.chomp

      until player_board.valid_placement?(ship, user_input.split)
        puts 'Sorry, those are invalid coordinates. Please try again:'
        print "> "
        user_input = gets.chomp
      end

      player_board.place(ship, user_input.split)
    end

    puts "\n"
  end

  def turn
    board_size
    create_ships
    comp_ship_placement
    player_ship_placement

    display_board

    until won?
      puts "\nEnter the coordinate for your shot:"
      print "> "

      user_input = gets.chomp
      until cpu_board.valid_coordinate?(user_input)
        if cpu_board.cell_fired_at?(user_input)
          puts "You've already fired at this coordinate....please enter a new one:"
          print "> "
          user_input = gets.chomp
        else
          puts 'Please enter a valid coordinate:'
          print "> "
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
    cpu_board.board_render(true)
    puts "\n"
    puts '==============PLAYER BOARD=============='
    player_board.board_render(true)
  end

  def won?
    players_sunk = player_ships.all? do |ship|
      ship.sunk?
    end

    cpu_sunk = cpu_ships.all? do |ship|
      ship.sunk?
    end

    players_sunk || cpu_sunk
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
    players_sunk = player_ships.all? do |ship|
      ship.sunk?
    end

    cpu_sunk = cpu_ships.all? do |ship|
      ship.sunk?
    end

    if players_sunk && cpu_sunk
      puts "\n\nWHOA...we tied"
    elsif players_sunk
      puts "\n\nI won!"
    elsif cpu_sunk
      puts "\n\nYou won!"
    else
      puts 'Uh oh, something went wrong!'
    end

    reset
    puts "\nWould you like to play again?\nEnter 'p' to play. Enter 'q' to quit."
    print "> "
    user_ready?
  end


end
