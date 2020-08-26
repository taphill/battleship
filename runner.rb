require './lib/board'
require './lib/ship'


board = Board.new
cruiser = Ship.new("Cruiser", 3)
board.place(cruiser, ["A1", "A2", "A3"])

board.board_render(true)
