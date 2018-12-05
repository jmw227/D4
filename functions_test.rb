require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'functions'

class FunctionsTest < Minitest::Test
  def setup
    @nodes = []
    @words = []
    @perms = []
    @legal_words = []
    @real_words = []
  end

  def test_file_in_file_exists
    fname = 'functions.rb'
	file = file_in fname
	assert file.is_a? File
  end
  
  def test_file_in_file_does_not_exist
    fname = ''
	assert_output(/file does not exist/) {file_in fname}
  end
  
  def test_parse_file_single_line
    file = ['0;A;']
	parse_file file
	assert_equal 0, @nodes[0].id
	assert_equal 'A', @nodes[0].letter
	assert_equal [], @nodes[0].neighbors
  end
  
  def test_parse_file_3_line
    file = ['0;A;1','1;B;']
	parse_file file
	assert_equal 2, @nodes.length
  end
  
  def test_parse_file_0_lines
    file = []
    parse_file file
	assert_equal 0, @nodes.length
  end
  
  def test_traverse_one_path
    
    @nodes = [MyNode.new(0,'A', [1]), MyNode.new(1,'B', [2]), MyNode.new(2,'C',[])]
	traverse @nodes[0], ''
	assert_equal 1, @words.length
  end
  
  def test_traverse_two_paths
	@nodes = [MyNode.new(0,'A', [1,2]), MyNode.new(1,'B', [2]), MyNode.new(2,'C',[])]
	traverse @nodes[0], ''
	assert_equal 2, @words.length
  end
  
  def test_permutation_2
    word = ['a','b']
	permutation word, 0,1
	assert_equal 2, @perms.length
  end
  
  def test_generate_dict
    file = ['word']
	generate_dict file
	assert_equal 1, @legal_words.length
  end
  
  def test_find_real_words
    @perms = ['ab']
	@legal_words = ['ab']
	find_real_words
	assert_equal 1, @real_words.length
  end

end