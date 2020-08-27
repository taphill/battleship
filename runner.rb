require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'

cpu_board = Board.new
player_board = Board.new
game = StartGame.new(cpu_board, player_board)

game.start
