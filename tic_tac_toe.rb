class Game
  def initialize(player_one, player_two)
    @board = Array(1..9)
    @winning_moves = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    @current_player, @next_player = [player_one, player_two].shuffle!
  end

  def display_board
    @board.each_with_index do |shape, index|
      print shape
      print " | " unless [2, 5, 8].include?(index)
      puts "\n--+---+--" if [2, 5].include?(index)
    end
    puts "\n\n"
  end

  def swap_players
    @current_player, @next_player = @next_player, @current_player
  end

  def valid_move?(move)
    (1..9).include?(move) && !["X", "O"].include?(@board[move - 1])
  end
  
  def game_over?
    @winning_moves.any? do |moves|
      moves.all? { |index| @board[index] == @current_player.shape }
    end
  end

  def set_player_move
    loop do
      print "Enter your choice (1-9): "
      move = gets.chomp.to_i
      if valid_move?(move)
        @board[move - 1] = @current_player.shape
        puts
        break
      end
    end
  end

  def play
    loop do
      puts "#{@current_player.shape}'s turn\n\n"
      display_board
      set_player_move

      if game_over?
        puts "#{@current_player.shape} wins!\n\n"
        display_board
        break
      end

      swap_players
    end
  end
end

class Player
  attr_reader :shape

  def initialize(shape)
    @shape = shape
  end
end

player_one = Player.new("X")
player_two = Player.new("O")

Game.new(player_one, player_two).play
