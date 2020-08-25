require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < MiniTest::Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_nil cell.ship

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_empty?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal false, cell.empty?

    cell.place_ship(cruiser)
    assert_equal true, cell.empty?
  end

  def test_place_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

end
