require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/traversal'
require_relative 'MyVertex'
def file_in
  if ARGV.length != 1
    puts 'Too few arguments'
    exit
  end
  file_name = ARGV[0]
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
	    neigh_int = nil
	  end
	  @vertices[data[0].to_i] = MyVertex.new(data[0].to_i,data[1],neigh_int)
    else
      @vertices[data[0].to_i] = MyVertex.new(data[0].to_i,data[1],nil)
    end
  end
end

def build_graph
  for v in @vertices
   if !v.nil?
    if !v.neighbors.nil?
      for n in v.neighbors
	    @graph.add_edge v.letter, @vertices[n].letter
	  end
	 end
	end
  end
end
@vertices = []
@graph = RGL::DirectedAdjacencyGraph.new
file = file_in
parse_file file
build_graph
#@graph.print_dotted_on
bfs = @graph.bfs_iterator
puts @graph.bfs_search_tree_from @vertices[7].letter
dfs = @graph.dfs_iterator
i=0
while i <5
  puts dfs.next_vertex
  i+=1
end
