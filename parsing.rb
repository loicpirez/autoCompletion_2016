# Class to parse a file formatted on autoComplete format.
class Parsing
  def check_file(file)
    unless File.file?(file) do
      STDERR.puts "[ERROR] File {#file} does not exist or can't be read."
      exit 84
    end
    end
  end

  def get_informations(index, regex, address)
    informations = Struct.new(:town, :number, :type, :name)
    if index.zero?
      town = regex.match(address).captures[0]
      number = regex.match(address).captures[1]
      type = regex.match(address).captures[2]
      name = regex.match(address).captures[3]
    elsif index == 1
      town = regex.match(address).captures[3]
      number = regex.match(address).captures[0]
      type = regex.match(address).captures[1]
      name = regex.match(address).captures[2]
    elsif index == 2
      town = regex.match(address).captures[0]
      number = 1
      type = regex.match(address).captures[1]
      name = regex.match(address).captures[2]
    elsif index == 3
      town = regex.match(address).captures[0]
      number = regex.match(address).captures[1]
      name = regex.match(address).captures[2]
      type = regex.match(address).captures[3]
    end
    informations.new(town.capitalize, number, type.capitalize, name.capitalize)
  end

  def read_file(file)
    dictionnary = []
    wrong_address = []
    autocorrection_regex = []
    regex = Regexp.new File.open('regex/simple', &:readline).chomp
    File.readlines('regex/autocorrection').each do |subregex|
      r = Regexp.new subregex.chomp
      autocorrection_regex.push(r)
    end
    begin
      File.readlines(file).each do |line|
        address = line.chomp
        if address =~ regex
          dictionnary.push(get_informations(0, regex, address))
        else
          matched = false
          autocorrection_regex.each_with_index do |subregex, index|
            next unless address =~ subregex
            dictionnary.push(get_informations(index, subregex, address))
            matched = true
            break
          end
          wrong_address.push(address) unless matched
        end
      end
    rescue Errno::ENOENT => e
      STDERR.puts "[ERROR] Can't read the file content of #{file}. (not exist? insuffisants rights?)"
      exit 84
    end
    unless wrong_address.length.zero?
      wrong_address.each do |wrong|
        puts wrong
      end
      STDERR.puts 'Unknown address'
      exit 84
    end
    dictionnary
  end

  def get_dictionnary(file)
    check_file(file)
    read_file(file)
  end
end
