require './lib/ship'
require './lib/cell'
require './lib/board'



board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
board.place(cruiser, ["A1", "A2", "A3"])
board.place(submarine, ["B4", "C4",])

board.cells['A1'].fire_upon
board.cells['A2'].fire_upon
board.cells['A3'].fire_upon

board.cells['B1'].fire_upon
board.cells['B3'].fire_upon
board.cells['B4'].fire_upon

#board.cells['E4'].fire_upon

board.board_render()
