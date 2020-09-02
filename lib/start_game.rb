class StartGame
  attr_reader :game
  def initialize(game)
    @game = game
  end

  def start
    game.intro
    if game.user_ready?
      game.turn
    else
      game.goodbye
    end
  end

end
