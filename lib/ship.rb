class Ship
  attr_accessor :length
  attr_reader :name

  def initialize(name, length)
    @name = name
    @length = length
  end

  def health
    length
  end

  def sunk?
    health <= 0
  end

  def hit
    return 'Already sunk' if length <= 0

    self.length -= 1
  end
end
