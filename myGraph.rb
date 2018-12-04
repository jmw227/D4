class MyGraph
  attr_accessor :vertices
  attr_accessor :edges
  def initialize
    @vertices = []
	@edges = [[]]
  end

  def add_vert(new_v)
    @vertices[new_v.id] = new_v
	arr = []
	if !new_v.neighbors.nil?
	for n in new_v.neighbors
	  arr[n] = 1 
	  end
	@edges[new_v.id] = arr
	end
  end
  
  def get_paths(start)
    str = []
	paths = []
    str.push(vertices[start].letter)
	num_paths = 0
	cur_vert = start
	if @edges[cur_vert].nil?
	
	else
	(0..@edges[cur_vert]-1).each do |i|
	  if !@edges[cur_vert][i].nil?
	    str.push cur_vert.letter
	  end
	end
	end
  end
end