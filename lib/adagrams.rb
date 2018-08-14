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
  puts "#{word}"
  word.each do |letter|
    # found = false
    # while !found
    puts "before deletion #{letters_in_hand}"
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
    puts "after delition #{letters_in_hand}"
  end
  return true
end
