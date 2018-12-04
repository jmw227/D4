require_relative 'myGraph'
require_relative 'myVertex'
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
    @graph.add_vert v
  end
  end
end

 def get_paths(start)
   @vertex_list[vertex_count] = start
   @vertex_count +=1
   @graphs.vertices[start].visited = true
   temp = @graph.vertices[start]
   if !@graph.vertices[start].neigh.nil?
    next_neigh = @graph.vertices[@graph.vertices[start].neigh[0]]
	if next_neigh.visited
	for  n in @graph.vertices[start].neigh
	  if !@graph.vertices[n].visited 
	    
	  end
	end
   end
   flag = 0;
   while !temp.nil?
     if @graph.vertices[temp.id].visited == 0
	   flag
	   get_paths(temp.id)
	 end
	 temp = @graph.vertices[temp.
   end
 end
@vertices = []
@graph = MyGraph.new
@vertex_list= []
@vertex_count = 0
file = file_in
parse_file file
build_graph
puts @graph.get_paths(5)
#puts @graph.edges.map {|x| x.join'|'}
