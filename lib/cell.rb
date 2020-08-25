class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @has_ship = false
    @fired_at = false
  end

  def empty?
    if has_ship
      false
    else
      true
    end
  end

  def place_ship(ship_to_add)
    self.ship = ship_to_add
    self.has_ship = true
  end

  def fire_upon
    self.fired_at = true
    return nil if empty?

    ship.length -= 1
  end

  def fired_upon?
    fired_at
  end

  def render(show_ship = false)
    if fired_upon? && empty? == false && ship.sunk?
      "X"
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && (empty? == false)
      "H"
    elsif (fired_upon? == false) && show_ship == true
      "S"
    elsif fired_upon? == false
      "."
    else
      "ERROR"
    end
  end

  private

  attr_accessor :has_ship, :fired_at
  attr_writer :ship
end
