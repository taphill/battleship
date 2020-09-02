require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < MiniTest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
    assert_nil cell.ship
  end

  def test_empty?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal true, cell.empty?

    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_it_can_place_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_fired_upon?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_fire_upon
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal 3, cruiser.health

    cell.fire_upon

    assert_equal 2, cruiser.health
  end

  def test_render
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render

    cell_1.fire_upon
    assert_equal "M", cell_1.render

    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.render
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)

    cell_2.fire_upon
    assert_equal "H", cell_2.render

    assert_equal false, cruiser.sunk?

    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
