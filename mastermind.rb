class Mastermind
  MAX_ATTEMPTS = 12

  def initialize
    @code = Array.new(4) {rand(1..6)}
  end

  def display_feedback(feedback)
    black_pegs = feedback.count("O")
    white_pegs = feedback.count("X")
    puts "\n#{black_pegs} black peg(s), #{white_pegs} white peg(s)\n\n"
  end

  def get_feedback(guess)
    guess = guess.digits.reverse
    feedback = []
    seen_count = Hash.new(0)

    # Find correctly placed pegs
    @code.each_index do |i|
      if guess[i] == @code[i]
        feedback[i] = "O"
        seen_count[guess[i]] += 1
      end
    end

    # Find incorrectly placed pegs
    @code.each_index do |i|
      if feedback[i] == "O"
        next
      elsif @code.include?(guess[i]) && seen_count[guess[i]] < @code.count(guess[i])
        feedback[i] = "X"
        seen_count[guess[i]] += 1
      end
    end

    display_feedback(feedback)
  end
  
  def valid_guess?(guess)
    guess.digits.length == 4 && guess.digits.all? { |num| num.between?(1, 6) }
  end

  def play
    puts "Welcome to Mastermind!"
    puts "Guess the 4-digit code. You have #{MAX_ATTEMPTS} attempts.\n\n"

    MAX_ATTEMPTS.times do |attempt|
      puts "Attempts remaining: #{MAX_ATTEMPTS - (attempt + 1)}\n\n"
      
      guess = nil
      loop do
        print "Enter your guess: "

        guess = gets.chomp.to_i

        break if valid_guess?(guess)

        puts "Invalid input. Please enter 4 numbers (1-6)."
      end

      get_feedback(guess)

      if guess == @code.join.to_i
        puts "Congratulations! You cracked the code!"
        break
      end

      if attempt == MAX_ATTEMPTS - 1
        puts "Game Over. The code was #{@code.join}"
      end
    end
  end
end

Mastermind.new.play
