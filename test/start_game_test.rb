require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'

class StartGameTest < MiniTest::Test

  def test_in_exists
    cpu_board = Board.new
    player_board = Board.new

    game = StartGame.new(cpu_board, player_board)

    assert_instance_of StartGame, game
  end

  def test_comp_ship_placement
    #tested throught the start_game runner file.
    #ensured valid placement and random placement.
  end

  def test_comp_ship_placement
    #tested player input
    #tested throught the start_game runner file.
    #ensured valid placement and random placement.
  end
end
