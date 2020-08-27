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
    #tested throught the start_game runner file.
    #ensured valid placement and random placement.
  end

  def test_comp_ship_placement
    #tested player input
    #tested throught the start_game runner file.
    #ensured valid placement and random placement.
  end
end
