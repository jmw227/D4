require_relative 'myNode'
def file_in(file_name)
  file = nil
  if File.exist?(file_name)
    file = File.open(file_name, 'r')
  else
    puts "#{file_name} does not exist"
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

# DEPRICATED
def permutation(word, left, right)
  if left == right
    temp = word.join ''
    temp = temp.downcase
    @perms.push temp unless temp == ''
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
    w = line.strip
    @legal_words[w.each_char.sort.join] = [] unless @legal_words.key?(w.each_char.sort.join)
    @legal_words[w.each_char.sort.join] << w
  end
end

def find_real_words
  @words.each_with_object({}) do |w, g|
    key = w.downcase.chars.sort.join
    values = if @legal_words.key?(key)
               (@legal_words[key] - [w])
             else
               []
             end
    g[w] = values
    @real_words = g.values
  end
  @real_words = @real_words.flatten
end

def find_longest_word
  @real_words.max_by(&:length) unless @real_words.empty?
end
