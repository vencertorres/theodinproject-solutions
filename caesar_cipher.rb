UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
LOWER = "abcdefghijklmnopqrstuvwxyz"

def caesar_cipher(string, shift_factor)
  string.each_char do |char|
    if UPPER.include? char
      print UPPER[(UPPER.index(char) + shift_factor) % 26]
    elsif LOWER.include? char
      print LOWER[(LOWER.index(char) + shift_factor) % 26]
    else
      print char
    end
  end
end
