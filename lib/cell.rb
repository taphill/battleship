class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @has_ship = false
    @fired_at = false
  end

  def empty?
    has_ship
  end

  def place_ship(ship_to_add)
    self.ship = ship_to_add
    self.has_ship = true
  end

  def fire_upon
    self.fired_at = true
    ship.length -= 1
  end

  def fired_upon?
    fired_at
  end

  private

  attr_accessor :has_ship, :fired_at
  attr_writer :ship
end
