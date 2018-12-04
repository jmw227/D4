class MyVertex
  attr_accessor :id
  attr_accessor :letter
  attr_accessor :neighbors
  def initialize id, let, neighbors
    @id = id
	@letter = let
	@neighbors = neighbors
	@visited = false
  end
end