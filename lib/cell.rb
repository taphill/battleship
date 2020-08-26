class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_at = false
  end

  def empty?
    !(ship.class == Ship)
  end

  def place_ship(ship_to_add)
    return 'ERROR: Must be ship object' unless ship_to_add.class == Ship

    self.ship = ship_to_add
  end

  def fire_upon
    self.fired_at = true
    return nil if empty?

    ship.length -= 1
  end

  def fired_upon?
    fired_at
  end

  def render(show = false)
    return 'X' if sunk?
    return 'M' if miss?
    return 'H' if hit?
    return '.' if not_fired_at
    return 'S' if show_ship(show)
  end

  private

  attr_accessor :fired_at
  attr_writer :ship

  def hit?
    fired_upon? && (empty? == false)
  end

  def miss?
    fired_upon? && empty?
  end

  def sunk?
    fired_upon? && (empty? == false) && ship.sunk?
  end

  def not_fired_at
    fired_upon? == false
  end

  def show_ship(show)
    (fired_upon? == false) && (show == true)
  end
end
