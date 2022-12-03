def read_elves(filename)
  file = File.read(filename)

  elves_input = file.split("\n\n")
  elves_hash = {}
  elves_input.each_with_index do |elf, index|
    elves_hash[index] = elf.split("\n").map(&:to_i).sum
  end

  elves_hash.sort_by { |_key, value| -value }
end

def puzzle
  elves = read_elves('./input.txt')
  puts("Top elves - #{elves[0]}, #{elves[1]}, #{elves[2]}")
  puts("Puzzle one - Top elf number #{elves[0][0] + 1}")
  puts("Puzzle two - Sum of top 3 calories #{elves[0][1] + elves[1][1] + elves[2][1]}")
end

puzzle
