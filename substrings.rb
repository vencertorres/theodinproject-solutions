dictionary = [
  "below", "down", "go", "going", "horn", "how", "howdy", 
  "it", "i", "low", "own", "part", "partner", "sit"
]

def substrings(string, dictionary)
  dictionary.inject(Hash.new(0)) do |hash, word|
    string.downcase.split.each do |_word|
      if _word.include?(word)
        hash[word] += 1
      end
    end

    hash
  end
end
