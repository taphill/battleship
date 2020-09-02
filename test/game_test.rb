require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'
require './lib/game'

class GameTest < MiniTest::Test

  def test_it_exists
    cpu_board = Board.new(6, 6)
    player_board = Board.new(6, 6)
    game = Game.new(cpu_board, player_board)

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    cpu_board = Board.new(6, 6)
    player_board = Board.new(6, 6)
    game = Game.new(cpu_board, player_board)

    assert_equal cpu_board, game.cpu_board
    assert_equal player_board, game.player_board
  end

  def test_reset
    cpu_board = Board.new(6, 6)
    player_board = Board.new(6, 6)
    game = Game.new(cpu_board, player_board)

    assert_equal 6, game.cpu_board.rows
    assert_equal 6, game.cpu_board.columns

    game.reset

    assert_equal 4, game.cpu_board.rows
    assert_equal 4, game.cpu_board.columns
  end


end
