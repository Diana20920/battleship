require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  # def test_it_exists
  #   game = Game.new
  #   assert_instance_of Game, game
  # end
  #
  # def test_displays_main_menu
  #   game = Game.new
  #   expected = "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
  #   assert_equal expected, game.menu_prompt
  # end

  def test_player_places_cruiser
    player_board = Board.new
    comp_board = Board.new
    game = Game.new(comp_board, player_board)
    # player_cruiser = Ship.new("Cruiser", 3)
    # p_cruiser_coordinate_array = ["A1", "A2", "A3"]
    game.player_place_cruiser
    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, player_board.render(true)
  end


end
