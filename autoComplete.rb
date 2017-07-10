#!/usr/bin/ruby

require_relative('complete.rb')
require_relative('dico_data.rb')
require_relative('parsing.rb')

def usage
  puts "USAGE\n\t./autoCompletion dictionnary"
  print "DESCRIPTION\n\tdictionnary file, containing one address per line,"
  puts ' serving as knowledge base'
  exit 84
end

def check_arguments
  ARGV.each do |arg|
    next if arg.eql? '-h'
    d = DicoData.new
    p = Parsing.new
    dictionnary = p.get_dictionnary(arg)
    d.print_recurrent_town(dictionnary)
    d.get_input()
  end
end

def main
  if ARGV.empty? || ARGV.include?('-h')
    usage
  else
    check_arguments
  end
end

main if $PROGRAM_NAME == __FILE__
