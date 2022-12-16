class TreeNode
  attr_accessor :child_nodes, :parent, :dir_size, :total_size
  attr_reader :folder_name

  def initialize(parent, folder_name, dir_size)
    @folder_name = folder_name
    @parent = parent
    @dir_size = dir_size
    @child_nodes = []
    @total_size = 0
  end
end

def command_ls(input, current_node)
  input.shift
  dir_lines = []
  dir_lines.push(input.shift) while !input.empty? && input.first[0] != '$'
  dir_lines.each do |line|
    i = line.split
    if i[0] != 'dir'
      current_node.dir_size += i[0].to_i
    else
      folder_name = i[1]
      new_node = TreeNode.new(current_node, folder_name, 0)
      current_node.child_nodes.push(new_node)
    end
  end
end

def command_cd(input, current_node)
  command = input.first.split
  if command[2] == '..'
    current_node.parent
  else
    current_node.child_nodes.select { _1.folder_name == command[2] }.first
  end
end

def calculate_total_size(node)
  node.total_size = node.dir_size
  node.child_nodes.each do |child|
    node.total_size += calculate_total_size(child)
  end
  node.total_size
end

def calculate_puzzle_one(node, total_score)
  node.total_size = node.dir_size
  node.child_nodes.each do |child|
    node.total_size += calculate_puzzle_one(child, total_score)
  end
  if node.total_size <= 100000
    total_score << node.total_size
  end
  node.total_size
end

def print_tree(node)
  puts("#{node.folder_name}, dir_size= #{node.total_size}")
  node.child_nodes.each { print_tree(_1) }
end

def read_into_tree(input)
  current_node = TreeNode.new(nil, '/', 0)
  root = current_node
  input.shift
  until input.empty?
    if input.first == '$ ls'
      command_ls(input, current_node)
    elsif input.first[0..3] == '$ cd'
      current_node = command_cd(input, current_node)
      input.shift
    end
  end
  root
end

def calculate_puzzle_two(node, candidates, target)
  if node.total_size > target
    candidates << node.total_size
  end
  node.child_nodes.each do |child|
    calculate_puzzle_two(child, candidates, target)
  end
end

def puzzle_one(filename)
  input = File.readlines(filename).map(&:chomp)
  root = read_into_tree(input)

  total_score = []
  calculate_puzzle_one(root, total_score)
  p total_score.sum
end

def puzzle_two(filename)
  input = File.readlines(filename).map(&:chomp)
  root = read_into_tree(input)
  free_space = 70000000 - calculate_total_size(root)
  space_need_to_delete = 30000000 - free_space
  
  candidates = []
  calculate_puzzle_two(root, candidates, space_need_to_delete)
  p candidates.min
end

puzzle_one('./input.txt')
puzzle_two('./input.txt')
