class Game

  def initialize(comp_board, player_board)
    @comp_board = comp_board
    @player_board = player_board
  end

  def menu_prompt
    puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
    @menu_selection = gets.chomp
  end

  def create_ships
    @player_cruiser = Ship.new("Cruiser", 3)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @comp_submarine = Ship.new("Submarine", 2)
  end


  def play
    if @menu_selection == "p"
      display_boards
    elsif @menu_selection == "q"
      puts "Quitter"
    end
  end

  def display_comp_board
    puts @comp_board.render
  end

  def display_player_board
    puts @player_board.render
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    display_comp_board
    puts "==============PLAYER BOARD=============="
    display_player_board
  end

  ####PLAYER CRUISER PLACEMENT

  def player_cruiser_coords
    create_ships
    puts "Enter the squares for the Cruiser (3 spaces):"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
  end

  def player_cruiser_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
    player_ok_to_place_cruiser_redo
  end

  def player_ok_to_place_cruiser
    player_cruiser_coords
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_cruiser_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
    player_ok_to_place_cruiser_redo
  end

  def player_ok_to_place_cruiser_redo
    if @player_board.valid_placement?(@player_cruiser, @p_cruiser_coords.split(" ").to_a) == true
      player_place_cruiser
    else
      player_cruiser_invalid_coords
    end
  end

  def player_place_cruiser
    @player_board.place(@player_cruiser, @p_cruiser_coords.split(" ").to_a)
  end

  ####### PLAYER SUBMARINE PLACEMENT#####

  def player_submarine_coords
    create_ships
    puts "Enter the squares for the Submarine (2 spaces):"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
  end

  def player_submarine_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
    player_ok_to_place_submarine_redo
  end

  def player_ok_to_place_submarine
    player_submarine_coords
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_submarine_invalid_coords
    puts "Those are invalid coordinates. Please try again:"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ").to_a
    player_ok_to_place_submarine_redo
  end

  def player_ok_to_place_submarine_redo
    if @player_board.valid_placement?(@player_submarine, @p_submarine_coords.split(" ").to_a) == true
      player_place_submarine
    else
      player_submarine_invalid_coords
    end
  end

  def player_place_submarine
    @player_board.place(@player_submarine, @p_submarine_coords.split(" ").to_a)
  end





end
