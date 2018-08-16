require 'pry'
require 'csv'

# WAVE 1
# The draw_letters method starts with a fresh pool of tiles and returns
# an array of 10 letters (the "hand").
def draw_letters
  # letter_pool is an array of hashes that represent available tiles in the game
  # in each hash, keys represent the letter on the tile
  # the value in each hash represents the number of tiles with that letter
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
    if (pull.values.reduce > 0) # if the selected letter has tiles in the pool
      letter = pull.keys.reduce # fetch the letter
      hand << letter # add the selected letter to the hand
      pull[letter] -= 1 # decrement the tiles available for selected letter
    end
  end
  return hand
end

# WAVE 2
# The uses_available_letters method accepts a word from the user and returns
# true if that word uses only letters available in hand, false if not.
def uses_available_letters?(input, letters_in_hand)
  # Create a copy of the hand to use within this method so the original hand
  # remains unaltered.
  new_letters_in_hand = letters_in_hand.map do |letter|
    letter
  end

  # To account for duplicate letters, delete letters from the hand as they are
  # matched with letters from user input.
  word = input.upcase.split("")
  word.each do |letter|
      if new_letters_in_hand.include?(letter)
        new_letters_in_hand.delete_at(new_letters_in_hand.index letter)
      else
        return false # returns false if any letter user entered isn't in hand
      end
  end
  return true # returns true only after all letters confirmed in hand
end

# WAVE 3
# The score_word method calculates the score for word by summing up the score
# of each tile.
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

# WAVE 4
# The highest_score_from method identifies the highest scoring word played
# by the user, using tie-breaking logic when necessary.
def highest_score_from(words)
  highest = {
        word: "",
        score: 0
  }

  words.each do |word|
    current_score = score_word(word)
    if current_score > highest[:score]
      highest[:score] = current_score
      highest[:word] = word
    elsif current_score == highest[:score]
      if word.length == 10 && highest[:word].length != 10
        highest[:score] = current_score
        highest[:word] = word
      elsif word.length < highest[:word].length && highest[:word].length != 10
        highest[:score] = current_score
        highest[:word] = word
      end
    end
  end
  return highest
end

# WAVE 5
# The is_in_english_dict? method checks to make sure the user entered a word
# that is in the English dictionary by comparing against a csv list of words.
def is_in_english_dict?(input)
  # Map csv words to an array
  dictionary_words = CSV.open('assets/dictionary-english.csv', headers: true).map do |row|
   row["Word"]
  end

  downcased_input = input.downcase
  if dictionary_words.include? downcased_input
    return true
  else
    return false
  end
end
