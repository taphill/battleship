class StartGame
  def initialize()
    
  end

  def start
    intro
    user_ready?
  end

  private

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

  def turn

  end
end