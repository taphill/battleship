require './lib/board'
require './lib/ship'


board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
board.place(cruiser, ["A1", "A2", "A3"])
board.place(submarine, ["B4", "C4", "D4"])

board.board_render(true)
