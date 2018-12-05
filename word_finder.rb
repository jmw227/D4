require_relative 'functions'
require 'flamegraph'
if ARGV.length != 1
  puts 'Too few arguments'
  exit
end
Flamegraph.generate('word_finder.html') do
  @nodes = []
  @words = []
  @perms = []
  @legal_words = {}
  @real_words = []
  file = file_in ARGV[0]
  exit if file.nil?
  parse_file file
  @nodes.each do |n|
    traverse(n, '') unless n.nil?
  end
  dict_file = file_in 'wordlist.txt'
  exit if file.nil?
  generate_dict dict_file
  find_real_words
  longest = find_longest_word
  if !longest.nil?
    puts "longest word in #{ARGV[0]} graph is #{longest}"
  else
    puts "no real words in #{ARGV[0]} graph"
  end
end
