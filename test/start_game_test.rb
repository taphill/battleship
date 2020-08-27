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
end
