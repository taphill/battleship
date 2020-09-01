class Board
  attr_accessor :rows, :columns
  attr_reader :cells

  def initialize(rows = 4, columns = 4)
    @rows = rows
    @columns = columns
    @cells = {}
  end

  def create_cells
    get_keys.each do |key|
      cells[key] = Cell.new(key)
    end
  end

  def valid_coordinate?(coordinate)
    return false unless cells.key?(coordinate)
    return false if cells[coordinate].fired_upon?

    cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    unless on_playing_board?(coordinates) && !(overlapping?(coordinates)) && (ship.length == coordinates.length)
      return false
    end

    split_coordinates = split_coordinates(coordinates)

    return true if same_row?(split_coordinates) && consecutive?(split_coordinates, 1)
    return true if same_column?(split_coordinates) && consecutive?(split_coordinates, 0)

    return false
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship) if cells.key?(coordinate)
    end
  end

  def board_render(show_ship = false)
    print ' '
    get_numbers.each do |number|
      print '  ' + number
    end

    print "\n"

    get_letters.each do |letter|
      print letter + ' '
      cells.each do |coordinate, cell|
        if coordinate[0] == letter && coordinate[1..2].to_i > 10
          print "  #{cell.render(show_ship)} "
        elsif coordinate[0] == letter
          print " #{cell.render(show_ship)} "
        end
      end
      print "\n"
    end
  end

  def cell_render(cell)
    cells[cell].render
  end

  def cell_fired_at?(coordinate)
    return false unless cells.key?(coordinate)

    cells[coordinate].fired_upon?
  end

  private

  def get_keys
    letters = get_letters.flat_map { |letter| [letter] * columns }
    numbers = get_numbers * columns

    keys = letters.map do |letter|
      numbers.map do |number|
        letter + number
      end
    end

    keys.flatten.uniq
  end

  def get_letters
    ('A'..'Z').to_a[0, rows]
  end

  def get_numbers
    ('1'..'26').to_a[0, columns]
  end

  def split_coordinates(coordinates)
    coordinates.map do |coordinate|
      letter = coordinate[0].ord
      number = coordinate[1..2].to_i
      [letter, number]
    end
  end

  def same_row?(coordinates)
    value = coordinates[0][0]

    coordinates.all? do |coordinate|
      coordinate[0] == value
    end
  end

  def same_column?(coordinates)
    value = coordinates[0][1]

    coordinates.all? do |coordinate|
      coordinate[1] == value
    end
  end

  def consecutive?(coordinates, index)
    flattened_array = coordinates.map do |coordinate|
      coordinate[index]
    end

    flattened_array.each_cons(2).all? do |current_num, next_num|
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
