class StartGame
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def start
    game.intro

    while game.user_ready?
      game.begin
      game.who_won_game?
      game.reset
      game.play_again?
    end

    game.goodbye
  end
end
