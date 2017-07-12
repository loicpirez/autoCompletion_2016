require 'io/console'

# Class to get data from extracted informations.
class DicoData
  def initialize
    @input = ''
    @matched_town = []
  end

  def count_words(words)
    frequency = Hash.new(0)
    words.each do |word|
      frequency[word.downcase] += 1
    end
    frequency
  end

  def get_input
    begin
      @input = STDIN.readline.capitalize
    rescue EOFError
      exit (0)
    end
  end

  def get_town_nb_array(dictionnary)
    town_array = []
    dictionnary.each do |subdico|
      town_spaces = subdico.town.to_s.split(' ')
      town_spaces.each do |splited|
        town_array.push(splited.to_s.capitalize)
      end
    end
    town_array
  end

  def get_town_elem_array(name, dictionnary)
    town_elem_array = []
    dictionnary.each do |d|
      town_elem_array.push(d) if d['town'] == name
    end
    town_elem_array
  end

  def print_recurrent_town(dictionnary)
    town_array = get_town_nb_array(dictionnary)
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

  def match_town(dictionnary)
    unless @input.length.equal? 0
      town = []
      dictionnary.each do |d|
        town.push(d['town'].split)
      end
      town = town.uniq
      town.each do |t|
        t.each do |arr|
          if arr.capitalize.index(@input.rstrip).equal? 0
            @matched_town.push(t)
            break
          end
        end
      end
    end
  end

  def print_matched_town
    @matched_town.each do |m|
      puts "=>#{m}=<"
    end
  end

  def print_match(town_elem_array)
    puts "=> #{town_elem_array[0]['town']}, #{town_elem_array[0]['number']} #{town_elem_array[0]['type']} #{town_elem_array[0]['name']}"
    exit 0
  end

  def street_get_array(town_elem_array)
    street = []
    town_elem_array.each do |t|
      street.push(t['name'])
    end
    street
  end

  def check_street_when_one_town(dictionnary)
    town = ''
    @matched_town.each do |e|
      e.each do |sub|
        town = "#{town}#{sub} "
      end
    end
    town = town.rstrip
    town_elem_array = get_town_elem_array(town, dictionnary)
    if town_elem_array.length.equal? 1
      print_match(town_elem_array)
    else
      street_get_array(town_elem_array).uniq.each_with_index do |s, i|
        print "{#{town.upcase}, #{s[0][0].downcase}}"
        if (i + 1).equal? street_get_array(town_elem_array).uniq.length
          print "\n"
        else
          print ' '
        end
      end
    end
  end

  def print_multiple_town()
    @matched_town.each do |m|
      print m
    end
  end

  def suggest(dictionnary)
    if @matched_town.length.equal? 0
      match_town(dictionnary)
      print_multiple_town if @matched_town.length > 1
    else
      if @matched_town.length > 1
        @matched_town.each do |m|
          m.each do |sub|
            if sub.rstrip == @input.rstrip
              puts sub.rstrip
              puts @input.rstrip
            end
          end
        end
      end
    end
    check_street_when_one_town(dictionnary) if @matched_town.length.equal? 1
  end
end


