class StartGame
  def initialize(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
  end

  def start
  #  intro
  #  user_ready?
  #  comp_ship_placement
  #  cpu_board.board_render(true)
    player_ship_placement
    player_board.board_render(true)
  end

  private

  attr_reader :cpu_board, :player_board

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
    cpu_cruiser = Ship.new('Cruiser', 3)
    cpu_submarine = Ship.new('Submarine', 2)

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

    player_cruiser = Ship.new('Cruiser', 3)
    player_submarine = Ship.new('Submarine', 2)

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
    #
  end
end
