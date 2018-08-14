require 'pry'

def draw_letters

  letter_pool = [
    {"A" => 9},
    {"B" => 2},
    {"C" => 2},
    {"D" => 4},
    {"E" => 12},
    {"F" => 2},
    {"G" => 3},
    {"H" => 2},
    {"I" => 9},
    {"J" => 1},
    {"K" => 1},
    {"L" => 4},
    {"M" => 2},
    {"N" => 6},
    {"O" => 8},
    {"P" => 2},
    {"Q" => 1},
    {"R" => 6},
    {"S" => 4},
    {"T" => 6},
    {"U" => 4},
    {"V" => 2},
    {"W" => 2},
    {"X" => 1},
    {"Y" => 2},
    {"Z" => 1}
  ]

  hand = []
  while (hand.length < 10) do
    pull = letter_pool[rand(26)]
    if (pull.values.reduce > 0)
      letter = pull.keys.reduce
      hand << letter
      pull[letter] -= 1
    end
  end

  return hand
end

def uses_available_letters?(input, letters_in_hand)

  word = input.upcase.split("")
  word.each do |letter|
    # found = false
    # while !found
      if letters_in_hand.include?(letter)
        # letters_in_hand.delete(letter)
        letters_in_hand.delete_at(letters_in_hand.index letter)
        # binding.pry
        ####takes out all of the letters
        # found = true
      else
        return false
      end
    # end
  end
  return true
end

def score_word(word)
  score = 0
  word.upcase.split("").each do |letter|
    if "AEIOULNRST".include? letter
      score += 1
    elsif "DG".include? letter
      score += 2
    elsif "BCMP".include? letter
      score += 3
    elsif "FHVWY".include? letter
      score += 4
    elsif "K".include? letter
      score += 5
    elsif "JX".include? letter
      score += 8
    elsif "QZ".include? letter
      score += 10
    end
  end
  if word.length >= 7
    score += 8
  end
  return score
end
