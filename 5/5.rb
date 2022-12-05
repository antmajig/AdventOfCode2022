def alpha?(char)
  char.match(/^[[:alpha:]]$/)
end

def read_crates
  file = File.read('./input.txt')
  crates_input = file.split("\n\n")[0].split("\n")
  col_string = crates_input.pop
  crates_input.reverse
  crates_array = []
  9.times do |n|
    col = n + 1
    col_index = col_string.index(col.to_s)

    crate_stack = []
    crates_input.each do |line|
      crate_stack.unshift(line[col_index]) if alpha?(line[col_index])
    end

    crates_array.push(crate_stack)
  end
  crates_array
end

def move_crates(crates_array)
  file = File.read('./input.txt')
  instructions = file.split("\n\n")[1].split("\n")

  instructions.each do |instruction|
    amount_to_move = instruction.split('move').last.split('from').first.strip.to_i
    from = instruction.split('from').last.split('to').first.strip.to_i
    to = instruction.split('to').last.strip.to_i

    amount_to_move.times do
      crates_array[to - 1].push(crates_array[from - 1].pop)
    end
  end
end

def move_crates9001(crates_array)
  file = File.read('./input.txt')
  instructions = file.split("\n\n")[1].split("\n")

  instructions.each do |instruction|
    amount_to_move = instruction.split('move').last.split('from').first.strip.to_i
    from = instruction.split('from').last.split('to').first.strip.to_i
    to = instruction.split('to').last.strip.to_i

    crates_array[to - 1] += crates_array[from - 1].pop(amount_to_move)
  end
end

def puzzle_one
  crates_array = read_crates
  move_crates(crates_array)

  answer_string = ''
  crates_array.each do |col|
    answer_string += col.last
  end
  puts("The answer to puzzle one is '#{answer_string}'")
end

def puzzle_two
  crates_array = read_crates
  move_crates9001(crates_array)

  answer_string = ''
  crates_array.each do |col|
    answer_string += col.last
  end
  puts("The answer to puzzle two is '#{answer_string}'")
end

puzzle_one
puzzle_two
