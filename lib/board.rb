class Board
  attr_reader :cells

  def initialize
    @cells = {
      'A1' => Cell.new('A1'),
      'A2' => Cell.new('A2'),
      'A3' => Cell.new('A3'),
      'A4' => Cell.new('A4'),
      'B1' => Cell.new('B1'),
      'B2' => Cell.new('B2'),
      'B3' => Cell.new('B3'),
      'B4' => Cell.new('B4'),
      'C1' => Cell.new('C1'),
      'C2' => Cell.new('C2'),
      'C3' => Cell.new('C3'),
      'C4' => Cell.new('C4'),
      'D1' => Cell.new('D1'),
      'D2' => Cell.new('D2'),
      'D3' => Cell.new('D3'),
      'D4' => Cell.new('D4')
    }
  end

  def valid_coordinate?(coordinate)
    return false unless cells.key?(coordinate)
    return false if cells[coordinate].fired_upon?

    cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false unless ship.length == coordinates.length
    return false unless on_playing_board?(coordinates)
    return false if overlapping?(coordinates)

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

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship) if cells.key?(coordinate)
    end
  end

  def board_render(show_ship = false)
    print "  1 2 3 4 \n"
    print "A #{cells['A1'].render(show_ship)} #{cells['A2'].render(show_ship)} #{cells['A3'].render(show_ship)} #{cells['A4'].render(show_ship)} \n"
    print "B #{cells['B1'].render(show_ship)} #{cells['B2'].render(show_ship)} #{cells['B3'].render(show_ship)} #{cells['B4'].render(show_ship)} \n"
    print "C #{cells['C1'].render(show_ship)} #{cells['C2'].render(show_ship)} #{cells['C3'].render(show_ship)} #{cells['C4'].render(show_ship)} \n"
    print "D #{cells['D1'].render(show_ship)} #{cells['D2'].render(show_ship)} #{cells['D3'].render(show_ship)} #{cells['D4'].render(show_ship)} \n"
  end

  def cell_render(cell)
    cells[cell].render
  end

  def cell_fired_at?(coordinate)
    return false unless cells.key?(coordinate)

    cells[coordinate].fired_upon?
  end

  private

  def split_coordinates(coordinates)
    coordinates.map do |coordinate|
      coordinate.split('').map(&:ord)
    end
  end

  def value_at_0_same?(coordinates)
    value = coordinates[0][0]

    coordinates.all? do |coordinate|
      coordinate[0] == value
    end
  end

  def value_at_1_same?(coordinates)
    value = coordinates[0][1]

    coordinates.all? do |coordinate|
      coordinate[1] == value
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

  def overlapping?(coordinates)
    coordinates.any? do |coordinate|
      cells[coordinate].ship.class == Ship
    end
  end

  def on_playing_board?(coordinates)
    coordinates.all? do |coordinate|
      cells.key?(coordinate)
    end
  end
end
