require_relative 'functions'
if ARGV.length != 1
  puts 'Too few arguments'
  exit
end
@nodes = []
@words = []
@perms = []
@legal_words = []
@real_words = []
file = file_in ARGV[0]
exit if file.nil?
parse_file file

@nodes.each do |n|
  traverse(n, '') unless n.nil?
end

(0..@words.length - 1).each do |i|
  permutation @words[i].chars, 0, @words[i].length - 1
end
dict_file = File.open('wordlist.txt', 'r')
generate_dict dict_file
find_real_words
longest_word = @real_words.max_by(&:length)
puts "Longest word from #{ARGV[0]} graph is #{longest_word}"
