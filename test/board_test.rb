require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_has_sixteen_cells
    board = Board.new

    board.cells.each do |coord, cell|
      assert_instance_of Cell, cell
    end
    assert_equal 16, board.cells.count
  end

  def test_valid_coordinate
    board = Board.new

    assert board.valid_coordinate?("B4")
  end

  def test_invalid_coorindate
    board = Board.new

    refute board.valid_coordinate?("E7")
  end

  def test_placing_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_valid_placement_ship_length_not_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.correct_length?(cruiser, ["A1", "A2"])
  end

  def test_valid_placement_ship_length_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert true, board.correct_length?(submarine, ["A1", "A2"])
  end

  def test_split_individual_coordinates_letter_ordinal_value
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal [65, 65, 65], board.split_return_letter_ordinal_value(cruiser, ["A1", "A2", "A3"])
  end

  def test_split_individual_coordinates_number
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal [1, 2, 3], board.split_return_number(cruiser, ["A1", "A2", "A3"])
  end

  def test_coordinates_are_same_row
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_same_row?(cruiser, ["A1", "A2", "A3"])
  end

  def test_coordinates_are_not_same_row
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_same_row?(cruiser, ["A1", "B1", "B2"])
  end

  def test_coordinates_are_same_column
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_same_column?(cruiser, ["A1", "B1", "C1"])
  end

  def test_coordinates_are_same_not_column?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_same_column?(cruiser, ["A1", "A2", "B2"])
  end

  # def test_coordinates_is_diagonal
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   assert_equal false, board.coordinates_diagonal?(cruiser, ["A1", "A2"])
  # end

  # def test_coordinates_is_not_diagonal
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   assert_equal true, board.coordinates_diagonal?(cruiser, ["A1", "B2"])
  # end

  def test_increments_by_true?
    board = Board.new
    test_array = [1, 3, 5]
    assert_equal true, board.increments_by?(2, test_array)
  end

  def test_increments_by_false?
    board = Board.new
    test_array = [1, 3, 5]
    assert_equal false, board.increments_by?(1, test_array)
  end

  def test_whole_coordinates_are_consectutive_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal true, board.coordinates_consecutive_horizontal?(cruiser, ["A1", "A2", "A3"])
  end

  def test_whole_coordinates_are_not_consectutive_horizontal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_consecutive_horizontal?(cruiser, ["A1", "A3", "A4"])
  end

  def test_whole_coordinates_are_consectutive_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_consecutive_vertical?(cruiser, ["A1", "B1", "C1"])
  end

  def test_whole_coordinates_are_not_consectutive_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_consecutive_vertical?(cruiser, ["A1", "C1", "D1"])
  end

  def test_overall_consecutive_true
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_overall_consecutive?(cruiser, ["A1", "A2", "A3"])
  end

  def test_overall_consecutive_false
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_overall_consecutive?(cruiser, ["A1", "B1", "C2"])
  end

  def test_ships_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal true, board.ship_overlap?(submarine, ["A1", "A2"])
  end

  def test_ships_do_not_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["B1"]
    cell_5 = board.cells["B2"]

    assert_equal false, board.ship_overlap?(submarine, ["B1", "B2"])
  end

  def test_valid_coordinates_scan?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal [false, true, true], board.valid_coordinates_scan(cruiser, ["A9", "A2", "A3"])
  end

  def test_valid_coordinates?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, board.valid_coords_check(cruiser, ["A9", "A2", "A3"])
  end

  def test_is_valid_placement?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end

  def test_the_board_can_render_at_start
    # require "pry"; binding.pry
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected1, board.render
  end

  def test_the_board_can_render_moves
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected2, board.render(true)
  end
end
