require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)
    assert_instance_of Game, game
  end

  # def test_comp_places_cruiser
  #   comp_board = Board.new
  #   player_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   game.comp_cruiser_placement
  #   expected = 123
  #   assert_equal expected, game.display_comp_board
  # end

  def test_comp_places_both_ships
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)
    expected = 123
    game.comp_ok_to_place_submarine
    assert_equal expected, game.display_comp_board
  end

  # def test_displays_main_menu
  #   comp_board = Board.new
  #   player_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   expected = "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
  #   assert_equal expected, game.menu_prompt
  # end

  # def test_create_ships
  #   comp_board = Board.new
  #   player_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   game.create_ships
  #
  #   assert_instance_of Ship, @player_cruiser
  #   assert_instance_of Ship, @comp_cruiser
  #   assert_instance_of Ship, @player_submarine
  #   assert_instance_of Ship, @comp_submarine
  # end

  # def test_player_places_cruiser
  #   player_board = Board.new
  #   comp_board = Board.new
  #   game = Game.new(comp_board, player_board)


  #   game.player_ok_to_place_cruiser
  #   expected = "  1 2 3 4 \nA S S . . \nB . . . . \nC . . . . \nD . . . . \n"
  #
  #   assert_equal expected, player_board.render(true)
  # end

  # def test_player_places_cruiser
  #   player_board = Board.new
  #   comp_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   player_cruiser = Ship.new("Cruiser", 3)
  #   player_board.place(player_cruiser, ["A1", "A2", "A3"])
  #   game.player_place_submarine
  #   expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  #
  #   assert_equal expected, player_board.render(true)
  # end

  # def test_player_places_cruiser_invalid
  #   player_board = Board.new
  #   comp_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   # player_cruiser = Ship.new("Cruiser", 3)
  #   # comp_cruiser = Ship.new("Cruiser", 3)
  #   # player_submarine = Ship.new("Submarine", 2)
  #   # player_submarine = Ship.new("Submarine", 2)
  #   # player_cruiser = Ship.new("Cruiser", 3)
  #   # player_board.place(player_cruiser, ["A1", "A2", "A3"])
  #   game.player_ok_to_place_cruiser
  #   expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  #
  #
  #   assert_equal expected, player_board.render(true)
  # end



end
