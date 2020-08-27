class StartGame
  def initialize(board)
    @board = board

  end

  def start
#    intro
#    user_ready?
    comp_ship_placement
    board.board_render(true)
  end

  private
  attr_reader :board
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
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    cruiser_coordinates = board.cells.keys.sample(3)
    until board.valid_placement?(cruiser, cruiser_coordinates)
      cruiser_coordinates = board.cells.keys.sample(3)
    end

    submarine_coordinates = board.cells.keys.sample(2)
    until board.valid_placement?(submarine, submarine_coordinates)
      submarine_coordinates = board.cells.keys.sample(2)
    end

    board.place(cruiser, cruiser_coordinates)
    board.place(submarine, submarine_coordinates)
  end

  def turn

  end
end
