require 'pry'
require 'csv'

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
  new_letters_in_hand = letters_in_hand.map do |letter|
    letter
  end

  word = input.upcase.split("")
  word.each do |letter|

      if new_letters_in_hand.include?(letter)
        new_letters_in_hand.delete_at(new_letters_in_hand.index letter)
      else
        return false
      end
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

def is_in_english_dict?(input)
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
