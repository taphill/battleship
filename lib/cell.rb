class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @has_ship = false
    @fired_at = false
  end

  def empty?
    @has_ship
  end

  def place_ship(ship_to_add)
    @ship = ship_to_add
    @has_ship = true
  end

  def fire_upon
    @fired_at = true
    ship.length -= 1
  end

  def fired_upon?
    @fired_at
  end
end
