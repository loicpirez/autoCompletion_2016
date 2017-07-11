require 'io/console'

# Class to get data from extracted informations.
class DicoData
  def initialize
    @input = ''
  end

  def count_words(words)
    frequency = Hash.new(0)
    words.each do |word|
      frequency[word.downcase] += 1
    end
    frequency
  end

  def get_input
    @input = STDIN.readline.capitalize
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
      hash[count[0][0]].nil? ? hash[count[0][0]] = count[1] : hash[count[0][0]] = hash[count[0][0]] + count[1]
    end
    hash.shift
    hash = hash.sort_by(&:last).to_h
    hash = hash.to_a.reverse.to_h
    hash.each_with_index do |h, i|
      limit = hash.length < 5 ? hash.length : 5
      i + 1 == limit ? (print "{#{hash.keys[i]}}\n") : (print "{#{hash.keys[i]}} ")
      break if i >= limit - 1
    end
  end

  def suggest(dictionnary)
    town = []
    dictionnary.each do |d|
      town.push(d['town'].split)
    end
    town = town.uniq
    town.each do |t|
      t.each do |arr|
        if arr.capitalize.index(@input.rstrip) == 0
          puts "#{t} <=> #{@input.rstrip}"
          break
        end
      end
    end
  end
end


