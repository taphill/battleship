require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'
require './lib/game'

class StartGameTest < MiniTest::Test

  def test_in_exists
    cpu_board = Board.new(6, 6)
    player_board = Board.new(6, 6)
    game = Game.new(cpu_board, player_board)

    start_game = StartGame.new(game)

    assert_instance_of StartGame, start_game
  end
end
