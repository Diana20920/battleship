class Game

  def initialize
    @comp_board = Board.new
    @player_board = Board.new
    @valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @player_shot = nil
    @comp_shot = nil
  end

  def final_game #1
    main_menu
    setup
  end

  def main_menu #2 (final_game)
    puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
    @menu_selection = gets.chomp
    sleep(1)
  end

  def setup #2 (final_game)
    if @menu_selection == "p"
      instructions
      sleep(3)
      create_ships
      comp_ok_to_place_submarine
      display_comp_board
      player_ok_to_place_cruiser
      display_player_board
      player_ok_to_place_submarine
      turn
    elsif @menu_selection == "q"
      puts "Thanks for stopping by - have a nice day!"
    else
      re_main_menu
    end
  end

  def re_main_menu #3 (setup)
    puts "You entered an invalid input. Please enter p to play or enter q to quit."
    @menu_selection = gets.chomp
    setup
    sleep(1)
  end

  def instructions #3 (setup)
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships. \nThe Cruiser is three units long and the Submarine is two units long."
  end

  def create_ships #3 (setup)
    @player_cruiser = Ship.new("Cruiser", 3)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @comp_submarine = Ship.new("Submarine", 2)
  end

  def turn #3 (setup)
    display_boards
    ok_to_fire_at_comp
    player_shot_feedback
    game_over_player?
  end

  def game_over_player? #4 (turn)
    if comp_alive == false
      player_won
      end_game
    else
      computer_shot_sequence
    end
  end

  def computer_shot_sequence #5 (game_over_player?)
    computer_shot
    computer_shot_feedback
    game_over_computer?
  end

  def game_over_computer? #6 (computer_shot_sequence)
    if player_alive == false
      comp_won
      end_game
    else
      turn
    end
  end

  def comp_alive #5 (game_over_player?)
    if (@comp_cruiser.sunk? == false || @comp_submarine.sunk? == false) == true
      true
    else
      false
    end
  end

  def player_alive #7 (game_over_computer?)
    if (@player_cruiser.sunk? == false || @player_submarine.sunk? == false) == true
      true
    else
      false
    end
  end

  def end_game #5 (game_over_player?) / #7 (game_over_computer)
    reset
    final_game
  end

  def reset # 6/8 (end_game)
    @comp_board = Board.new
    @player_board = Board.new
    @valid_targets = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @player_shot = nil
    @comp_shot = nil
  end

  def player_won #(game_over_player)
    if player_alive == true
      puts "You won!"
    end
  end

  def comp_won # (game_over_computer)
    if comp_alive == true
      puts "I won!"
    end
  end

  def display_comp_board #(setup)/(display_boards)
    puts @comp_board.render
  end

  def display_player_board #(setup/display_boards)
    puts @player_board.render(true)
  end

  def display_boards #(turn)
    puts "=============COMPUTER BOARD============="
    display_comp_board
    puts "==============PLAYER BOARD=============="
    display_player_board
  end

  def comp_cruiser_placement #(refine_valid_submarine_placements)
    @valid_cruiser_placements = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
    @comp_cruiser_coords = @valid_cruiser_placements.sample
    @comp_board.place(@comp_cruiser, @comp_cruiser_coords)
  end

  def refine_valid_submarine_placements #(comp_ok_to_place_submarine)
    comp_cruiser_placement
    @valid_submarine_placements = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    @valid_submarine_placements.delete_if do |placement|
      placement.include?(@comp_cruiser_coords[0]) ||
      placement.include?(@comp_cruiser_coords[1]) ||
      placement.include?(@comp_cruiser_coords[2])
    end
    @comp_submarine_coords = @valid_submarine_placements.sample
  end

  def comp_ok_to_place_submarine ####CEO METHOD (setup)
    refine_valid_submarine_placements
    if @comp_board.valid_placement?(@comp_submarine, @comp_submarine_coords) == true
      comp_place_submarine
    else
      comp_reselect_submarine_cords
    end
  end

  def comp_place_submarine #(comp_ok_to_place_submarine)(comp_ok_to_place_submarine_redo)
    @comp_board.place(@comp_submarine, @comp_submarine_coords)
  end

  def comp_reselect_submarine_cords #(comp_ok_to_place_submarine)(comp_ok_to_place_submarine_redo)
    @comp_submarine_coords = @valid_submarine_placements.sample
    comp_ok_to_place_submarine_redo
  end

  def comp_ok_to_place_submarine_redo #(comp_reselect_submarine_cords)
    if @comp_board.valid_placement?(@comp_submarine, @comp_submarine_coords) == true
      comp_place_submarine
    else
      comp_reselect_submarine_cords
    end
  end

  def computer_shot #(computer_shot_sequence)
    @comp_shot = @valid_targets.sample
    @player_board.cells[@comp_shot].fire_upon
    @valid_targets.delete_if do |target|
      target == @comp_shot
    end
  end

  def computer_shot_feedback #(computer_shot_sequence)
    if @player_board.cells[@comp_shot].empty? == true
      puts "My shot on #{@comp_shot} was a miss."
    elsif @player_board.cells[@comp_shot].ship.sunk? == false
      puts "My shot on #{@comp_shot} was a hit."
    else
      puts "My shot on #{@comp_shot} was a hit and it sunk a ship."
    end
  end

  def player_ok_to_place_cruiser #CEO METHOD (setup)
    player_cruiser_coords
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_cruiser_coords #(player_ok_to_place_cruiser)
    puts "Enter the squares for the Cruiser (3 spaces):"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
  end

  def player_cruiser_invalid_coords #(player_ok_to_place_cruiser)
    puts "Those are invalid coordinates. Please try again:"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
    player_ok_to_place_cruiser_redo
  end

  def player_ok_to_place_cruiser_redo #(player_cruiser_invalid_coords)
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_place_cruiser #(player_ok_to_place_cruiser)(player_ok_to_place_cruiser_redo)
    @player_board.place(@player_cruiser, @p_cruiser_coords.split(" ").to_a)
  end

  def player_ok_to_place_submarine ###CEO METHOD (setup)
    player_submarine_coords
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_submarine_coords #(player_ok_to_place_submarine)
    puts "Enter the squares for the Submarine (2 spaces):"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
  end

  def player_submarine_invalid_coords #(player_ok_to_place_submarine)
    puts "Those are invalid coordinates. Please try again:"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
    player_ok_to_place_submarine_redo
  end

  def player_ok_to_place_submarine_redo #(player_submarine_invalid_coords)
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_place_submarine #(player_ok_to_place_submarine)
    @player_board.place(@player_submarine, @p_submarine_coords.split(" ").to_a)
  end

  def ok_to_fire_at_comp ###CEO METHOD (setup)
    player_shot
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def player_shot #(ok_to_fire_at_comp)
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.chomp
  end

  def player_invalid_shot #(ok_to_fire_at_comp) (player_ok_to_fire_at_comp_redo)(ok_to_fire_at_comp_same_cell)(ok_to_fire_at_comp_after_same_shot_prompt)
    puts "Please enter a valid coordinate:"
    @player_shot = gets.chomp
    player_ok_to_fire_at_comp_redo
  end

  def player_fire_on_comp #(ok_to_fire_at_comp_same_cell)
    @comp_board.cells[@player_shot].fire_upon
  end

  def player_ok_to_fire_at_comp_redo #(player_invalid_shot)
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def ok_to_fire_at_comp_same_cell #(player_already_fired_on_cell)
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_fire_on_comp
    else
      player_invalid_shot
    end
  end

  def player_already_fired_on_cell #(ok_to_fire_at_comp_after_same_shot_prompt) (ok_to_fire_at_comp)(player_ok_to_fire_at_comp_redo)(ok_to_fire_at_comp_same_cell)
    if @comp_board.cells[@player_shot].was_fired_upon == true
      puts "You have already fired upon that cell. Please enter a different cell to fire upon:"
      @player_shot = gets.chomp
      ok_to_fire_at_comp_after_same_shot_prompt
    else
      ok_to_fire_at_comp_same_cell
    end
  end

  def ok_to_fire_at_comp_after_same_shot_prompt #(player_already_fired_on_cell)
    if @comp_board.valid_coordinate?(@player_shot) == true
      player_already_fired_on_cell
    else
      player_invalid_shot
    end
  end

  def player_shot_feedback #(turn)
    if @comp_board.cells[@player_shot].empty? == true
      puts "Your shot on #{@player_shot} was a miss."
    elsif @comp_board.cells[@player_shot].ship.sunk? == false
      puts "Your shot on #{@player_shot} was a hit."
    else
      puts "Your shot on #{@player_shot} was a hit and it sunk a ship."
    end
  end

end
