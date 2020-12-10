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

  # def test_valid_placement_ship_length_not_valid
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   refute board.valid_placement?(cruiser, ["A1", "A2"])
  # end
  #
  # def test_valid_placement_ship_length_valid
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   assert board.valid_placement?(submarine, ["A1", "A2"])
  # end

  def test_split_individual_coordinates_letter_ordinal_value
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal [65, 65], board.split_return_letter_ordinal_value(cruiser, ["A1", "A2"])
  end

  def test_split_individual_coordinates_number
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal [1, 2], board.split_return_number(cruiser, ["A1", "A2"])
  end

  def test_coordinates_are_same_row
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_same_row?(cruiser, ["A1", "A2"])
  end

  def test_coordinates_are_not_same_row
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_same_row?(cruiser, ["A1", "B1"])
  end

  def test_coordinates_are_same_column
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.coordinates_same_column?(cruiser, ["A1", "B1"])
  end

  def test_coordinates_are_same_not_column?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.coordinates_same_column?(cruiser, ["A1", "A2"])
  end

  def test_whole_coordinates_are_consectutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.are_whole_coordinates_consecutive?(cruiser, ["A1", "A2"])
  end

  def test_whole_coordinates_are_not_consectutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, board.are_whole_coordinates_consecutive?(cruiser, ["A1", "A3"])
  end
  # def test_valid_placement_not_in_line
  #   board = Board.new
    # cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   assert_equal true, board.valid_placement?(cruiser, ["A1", "A2"])
  # end


  # def test_valid_placement_no_overlap
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #   board.place(cruiser, ["A1", "A2", "A3"])
  #   cell_1 = board.cells["A1"]
  #   cell_2 = board.cells["A2"]
  #   cell_3 = board.cells["A3"]
  #
  #   refute board.valid_placement?(submarine, ["A1", "A2"])
  # end
  def test_the_board_can_render_at_start
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
