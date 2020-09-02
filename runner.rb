require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/start_game'

cpu_board = Board.new
player_board = Board.new
game = Game.new(cpu_board, player_board)

run_game = StartGame.new(game)

run_game.start
