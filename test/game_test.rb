require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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

  def test_it_has_final_game_method
    comp_board = mock
    player_board = mock
    game = Game.new(comp_board, player_board)

    game.expects(:main_menu)
    game.expects(:setup)
    game.expects(:turn)
    game.expects(:game_over?)
    game.expects(:end_game)
    game.final_game
  end
  ###MAIN MENU TESTS
  def test_displays_main_menu #MAY NOT NEED SINCE USER INPUT REQ.
    skip
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)
    expected = "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
    assert_equal expected, game.menu_prompt
  end

  def test_if_invalid_input_at_main_menu #MAY NOT NEED SINCE USER INPUT REQ.
    skip
  end
  ### SETUP TESTS
  def test_it_can_setup
    skip
  end
  ## TURN TETS
  def test_it_has_turns
    comp_board = mock
    player_board = mock
    game = Game.new(comp_board, player_board)

    game.expects(:display_boards)
    game.expects(:ok_to_fire_at_comp)
    game.expects(:computer_shot)
    game.expects(:player_shot_feedback)
    game.expects(:computer_shot_feedback)
    game.expects(:sleep).returns(2)
    game.expects(:game_over?)

    game.turn
  end
  ### GAME OVER TESTS
  def test_is_game_over?
    skip
  end

  def test_if_comp_alive
    skip
  end

  def test_if_player_alive
    skip
  end
  #### END GAME TESTS
  def test_end_game
    comp_board = mock
    player_board = mock
    game = Game.new(comp_board, player_board)

    game.expects(:player_won)
    game.expects(:comp_won)
    game.expects(:sleep).returns(2)
    game.expects(:final_game)

    game.end_game
  end

  def test_the_player_won
    skip
  end

  def test_the_comp_won
    skip
  end

  def test_create_ships
    skip
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)
    game.create_ships

    assert_instance_of Ship, @player_cruiser
    assert_instance_of Ship, @comp_cruiser
    assert_instance_of Ship, @player_submarine
    assert_instance_of Ship, @comp_submarine
  end

  def test_it_displays_instructions
    comp_board = mock
    player_board = mock
    game = Game.new(comp_board, player_board)

    expected = "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
    assert_equal expected, game.instructions
  end

  def test_display_comp_board
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, game.display_comp_board
  end

  def test_display_player_board
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, game.display_player_board
  end

  def test_display_both_boards
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)

    expected = ("=============COMPUTER BOARD============= \n"
                "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n" +
                "==============PLAYER BOARD============== \n"
                "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n")
    assert_equal expected, game.display_boards
  end

  #####COMPUTER SHIP PLACEMENT TESTS

  # def test_comp_places_cruiser
  #   comp_board = Board.new
  #   player_board = Board.new
  #   game = Game.new(comp_board, player_board)
  #   game.comp_cruiser_placement
  #   expected = 123
  #   assert_equal expected, game.display_comp_board
  # end

  def test_comp_places_both_ships
    skip
    comp_board = Board.new
    player_board = Board.new
    game = Game.new(comp_board, player_board)
    expected = 123
    game.comp_ok_to_place_submarine
    assert_equal expected, game.display_comp_board
  end

  ### COMPUTER SHOT TESTS


  ####PLAYER CRUISER PLACEMENT TESTS

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

  ####### PLAYER SUBMARINE PLACEMENT TESTS

  ### TURN TESTS
end
