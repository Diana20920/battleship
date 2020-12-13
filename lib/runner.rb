# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
#
comp_board = Board.new
player_board = Board.new
# comp_cruiser = Ship.new("Cruiser", 3)
# comp_sub = Ship.new("Submarine", 2)
# player_cruiser = Ship.new("Cruiser", 3)
# player_sub = Ship.new("Submarine", 2)
game = Game.new(comp_board, player_board)

# game.menu_prompt
# game.play
# game.display_boards
# game.player_place_cruiser
# game.player_add_submarine
# puts game.ok_to_fire_at_comp
# puts game.player_shot_feedback

# valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
# valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
# valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

# valid_cruiser_sample = valid_cruiser_placements.sample
# puts valid_cruiser_sample
# valid_submarine_sample = valid_submarine_placements.sample
# puts valid_submarine_sample
# shot = valid_targets.sample
# puts shot

puts game.final_game
