require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/start_game'

board = Board.new
game = StartGame.new

game.start
