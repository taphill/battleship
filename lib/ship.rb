class Ship
  attr_reader :name
  attr_accessor :length

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

    @length -= 1
  end
end
