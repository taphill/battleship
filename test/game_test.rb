require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/start_game'

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
    assert_equal [], game.cpu_ships
    assert_equal [], game.player_ships
  end

  def test_it_can_reset
    cpu_board = Board.new(6, 6)
    player_board = Board.new(6, 6)
    game = Game.new(cpu_board, player_board)

    assert_equal 6, game.cpu_board.rows
    assert_equal 6, game.cpu_board.columns
    assert_equal 6, game.player_board.rows
    assert_equal 6, game.player_board.columns

    game.reset

    assert_equal 4, game.cpu_board.rows
    assert_equal 4, game.cpu_board.columns
    assert_equal 4, game.player_board.rows
    assert_equal 4, game.player_board.columns
  end

  def test_if_player_or_cpu_won
    cpu_board = Board.new
    player_board = Board.new

    game = Game.new(cpu_board, player_board)

    assert_equal true, game.won?

    game.player_ships << Ship.new("Cruiser", 3)
    game.player_ships << Ship.new("Submarine", 2)
    game.cpu_ships << Ship.new("Cruiser", 3)
    game.cpu_ships << Ship.new("Submarine", 2)

    assert_equal false, game.won?
  end
end
