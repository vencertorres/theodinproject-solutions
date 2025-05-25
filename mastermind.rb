class Mastermind
  def initialize
    @secret = Array.new(4) {rand(1..6)}
    @max_turns = 12
    reset
  end

  def display_board
    puts "\n#{@guess.join(" ")} | #{@feedback.compact.join(" ")}\n\n"
  end

  def valid_guess?(guess)
    (1..6).include?(guess)
  end

  def check_guess
    seen_count = Hash.new(0)

    # Find correctly placed pegs
    @secret.each_with_index do |peg, i|
      if @guess[i] == peg
        @feedback[i] = "O"
        seen_count[peg] += 1
      end
    end

    # Find incorrectly placed pegs
    @secret.each_index do |i|
      if @feedback[i] == "O"
        next
      elsif @secret.include?(@guess[i]) && seen_count[@guess[i]] < @secret.count(@guess[i])
        @feedback[i] = "X"
        seen_count[@guess[i]] += 1
      end
    end
  end
  
  def set_player_guess
    (1..4).each do |peg|
      loop do
        print "Peg ##{peg} (1-6): "
        current_guess = gets.chomp.to_i
        if valid_guess?(current_guess)
          @guess << current_guess
          break
        end
      end
    end
  end

  def reset
    @guess = []
    @feedback = Array.new(4) {nil}
  end

  def play
    (1..@max_turns).each do |turn|
      puts "Turns remaining: #{@max_turns - turn}\n\n"
      set_player_guess
      check_guess
      display_board

      if @secret.each_with_index.all? { |peg, i| peg == @guess[i] }
        puts "You win!"
        break
      end

      if turn == @max_turns
        puts "Game Over"
        puts "Secret: #{@secret.join(" ")}\n\n"
      end

      reset
    end
  end
end

Mastermind.new.play
