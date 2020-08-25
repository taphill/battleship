class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @has_ship = false
  end

  def empty?
    @has_ship
  end

  def place_ship(ship_to_add)
    @ship = ship_to_add
    @has_ship = true
  end
end
