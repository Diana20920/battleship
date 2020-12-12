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
    @player_submarine = Ship.new("Submarine", 2)
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

  def player_cruiser_coords
    puts "Enter the squares for the Cruiser (3 spaces):"
    @p_cruiser_coords = gets.chomp
    @p_cruiser_coords.split(" ").to_a
  end

  def player_submarine_coords
    puts "Enter the squares for the Submarine (2 spaces):"
    @p_submarine_coords = gets.chomp
    @p_submarine_coords.split(" ")
  end

  def player_place_cruiser
    create_ships
    player_cruiser_coords
    @player_board.place(@player_cruiser, @p_cruiser_coords.split(" ").to_a)
  end

  def player_place_submarine
    create_ships
    player_submarine_coords
    @player_board.place(@player_submarine, @p_submarine_coords.split(" ").to_a)
  end 

  #   player_submarine_coords
  #   @player_board.place(@player_sub, @p_submarine_coordinate_array)
  # end



  # def computer_setup_board


end
