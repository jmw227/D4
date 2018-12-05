require_relative 'myNode'
def file_in(file_name)
  file = nil
  if File.exist?(file_name)
    file = File.open(file_name, 'r')
  else
    puts 'file does not exist'
  end
  file
end

def parse_file(file)
  file.each do |line|
    data = line.split(';')
    if data.length == 3
      neigh = data[2].split(',')
      neigh_int = neigh.map(&:to_i)
      neigh_int = [] if neigh_int[0].zero?
      @nodes[data[0].to_i] = MyNode.new(data[0].to_i, data[1], neigh_int)
    else
      @nodes[data[0].to_i] = MyNode.new(data[0].to_i, data[1], [])
    end
  end
end

def traverse(start, word)
  if start.neighbors.empty?
    word += start.letter
    @words.push word
  else
    start.neighbors.each do |n|
      traverse(@nodes[n], word + start.letter)
    end
  end
end

def permutation(word, left, right)
  if left == right
    temp = word.join ''
    temp = temp.downcase
    @perms.push temp
  else
    (left..right).each do |i|
      word = swap word, left, i
      permutation word, left + 1, right
      word = swap word, left, i
    end
  end
end

def swap(word, loc1, loc2)
  temp = word[loc1]
  word[loc1] = word[loc2]
  word[loc2] = temp
  word
end

def generate_dict(file)
  file.each do |line|
    @legal_words.push line.strip
  end
end

def find_real_words
  @perms.each do |n|
    @real_words.push n if @legal_words.include? n
  end
end
