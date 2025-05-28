class Hangman
  HANGMAN = [
    <<~STRING,
    ----
    |
    |
    |
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |
    |
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    |
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    |  |
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    | /|
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    | /|\\
    |
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    | /|\\
    | /
    |
    =====
    STRING

    <<~STRING,
    ----
    |  | 
    |  O
    | /|\\
    | / \\
    |
    =====
    STRING
  ]

  def initialize
    words = File.readlines("google-10000-english-no-swears.txt", chomp: true)
    @secret_word = words.filter { |word| word.length.between?(5, 12) }.sample
    @correct_letters = []
    @incorrect_letters = []
    @attempts = 0
  end

  def display_hangman
    puts HANGMAN[@attempts]

    puts "Incorrect letters: #{@incorrect_letters.map(&:upcase).join(" ")}\n\n"

    @secret_word.each_char do |char|
      if @correct_letters.include?(char)
        print char.upcase
      else
        print "_"
      end
      print " "
    end

    puts
  end

  def check_guess(guess)
    if @secret_word.include?(guess)
      @correct_letters << guess
    else
      @incorrect_letters << guess
      @attempts += 1
    end
  end

  def get_player_guess
    loop do
      print "Guess a letter: "
      guess = gets.chomp

      if guess.length != 1
        puts "Please enter a single letter."
      elsif (@correct_letters + @incorrect_letters).include?(guess)
        puts "You have already guessed that letter. Choose again."
      elsif !("a".."z").include?(guess) && !("A".."Z").include?(guess)
        puts "Please enter a letter."
      else
        return guess
      end
    end
  end

  def play
    loop do
      display_hangman
      guess = get_player_guess
      check_guess(guess)

      if @secret_word.chars.all? { |letter| @correct_letters.include?(letter) }
        puts "Congratulations! The secret word is: #{@secret_word.upcase}"
        break
      end

      if @attempts == 7
        display_hangman
        puts "Game over. The secret word is: #{@secret_word.upcase}"
        break
      end
    end
  end
end

Hangman.new.play
