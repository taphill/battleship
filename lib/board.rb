require './lib/cell'

class Board
  attr_reader :cells
  def initialize
    @cells = {"A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C1"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    #return true if ship.length == coordinates.length

    split_coordinates = split_coordinates(coordinates)

    if value_at_0_same?(split_coordinates) && value_at_1_same?(coordinates)
      false
    elsif value_at_0_same?(split_coordinates)
      consecutive?(flatten_array(split_coordinates, 1))
    elsif value_at_1_same?(split_coordinates)
      consecutive?(flatten_array(split_coordinates, 0))
    else
      false
    end
  end

  private

  def split_coordinates(coordinates)
    coordinates.map do |coordinate|
      coordinate.split('').map do |character|
        character.ord
      end
    end
  end

  def value_at_0_same?(coordinates)
    value = coordinates[0][0]

    coordinates.all? do |block|
      block[0] == value
    end
  end

  def value_at_1_same?(coordinates)
    value = coordinates[0][1]

    coordinates.all? do |block|
      block[1] == value
    end
  end

  def flatten_array(coordinates, index)
    coordinates.map do |coordinate|
      coordinate[index]
    end
  end

  def consecutive?(array)
    array.each_cons(2).all? do |current_num, next_num|
      next_num == current_num + 1
    end
  end
end