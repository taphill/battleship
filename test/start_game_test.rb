require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'

class StartGameTest < MiniTest::Test

  def test_in_exists
    game = StartGame.new

    assert_instance_of StartGame, game
  end

  def test_comp_ship_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    #assert_equal
  end
end
