require_relative 'myNode'
def file_in file_name
  if File.exist?(file_name)
    file = File.open(file_name, 'r')
  else
    puts 'file does not exist'
    exit
  end
  file
end

def parse_file file
  file.each do |line|
    data = line.split(';')
	#puts data[2]
	if data.length == 3
	  neigh = data[2].split(',')
	  neigh_int = neigh.map(&:to_i)
	  if neigh_int[0] == 0
	    neigh_int = []
	  end
	  @nodes[data[0].to_i] = MyNode.new(data[0].to_i,data[1],neigh_int)
    else
      @nodes[data[0].to_i] = MyNode.new(data[0].to_i,data[1],[])
    end
  end
end

 def traverse(start, word)

   if start.neighbors.length == 0
     word += start.letter
     @words.push word
   else 
     start.neighbors.each do |n|
	   traverse(@nodes[n], word+start.letter)
	 end
 end
 
 end
 
def permutation(word, l, r)
  if l == r
    temp = word.join ''
	temp = temp.downcase
    @perms.push temp
  else
    (l..r).each do |i|
	  word = swap word, l, i
	  permutation word, l+1, r
	  word = swap word, l, i
	end
  end
end

def swap(word, n1, n2)
  temp = word[n1]
  word[n1]=word[n2]
  word[n2]=temp
  word
end

def get_dict file
  file.each do |line|
    @legal_words.push line.strip
  end
end

def get_real_words
  @perms.each do |n|
    if @legal_words.include? n
	  @real_words.push n
	else
	  #puts'stupid'
	end
  end	
end

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
parse_file file

@nodes.each do |n|
  if !n.nil?
  traverse(n, '')
  end
  
end

(0..@words.length-1).each do |i|
  permutation @words[i].chars,0, @words[i].length-1
end
dict_file = File.open('wordlist.txt','r')
get_dict dict_file
get_real_words
longest_word = @real_words.max_by(&:length)
puts "Longest word from #{ARGV[0]} graph is #{longest_word}"



