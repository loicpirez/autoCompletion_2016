require 'io/console'

# Class to get data from extracted informations.
class DicoData

  def count_words(words)
    frequency = Hash.new(0)
    words.each {|word| frequency[word.downcase] += 1}
    frequency
  end

  def get_input
    STDIN.each_with_index do |line, idx|
      puts line
    end
  end

  def print_recurrent_town(dictionnary)
    town_array = []
    dictionnary.each do |subdico|
      town_spaces = subdico.town.to_s.split(' ')
      town_spaces.each do |splited|
        town_array.push(splited.to_s.capitalize)
      end
    end
    hash = {'' => ''}
    count_words(town_array).sort.reverse.to_h.each do |count|
      if hash[count[0][0]].nil? then
        hash[count[0][0]] = count[1]
      else
        hash[count[0][0]] = hash[count[0][0]] + count[1]
      end
    end
    hash.shift
    hash = hash.sort_by(&:last).to_h
    hash = hash.to_a.reverse.to_h

    hash.each_with_index do |h,i|
      limit = hash.length < 5 ? hash.length : 5
      i + 1 == limit ? (print "{#{hash.keys[i]}}\n") : (print "{#{hash.keys[i]}} ")
      break if i >= limit - 1
    end
  end
end

