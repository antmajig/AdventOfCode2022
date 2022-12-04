require 'set'
def puzzle_one
  file = File.read('./input.txt')
  char_values = {}
  (('a'..'z').zip(1..26)).each { |x| char_values[x[0]] = x[1] }
  (('A'..'Z').zip(27..52)).each { |x| char_values[x[0]] = x[1] }

  total_sum = 0
  file.lines.each do |line|
    first_container = line[0..(line.length / 2) - 1]
    second_container = line[line.length / 2..line.length - 1]
    common_char =
      first_container.chars.to_set.intersection(second_container.chars.to_set)

    total_sum += char_values[common_char.to_a[0]]
  end

  puts("The score for puzzle one is #{total_sum}")
end

def puzzle_two
  file = File.read('./input.txt')
  char_values = {}
  ('a'..'z').zip(1..26).each { |x| char_values[x[0]] = x[1] }
  ('A'..'Z').zip(27..52).each { |x| char_values[x[0]] = x[1] }

  total_sum = 0
  file.lines.each_slice(3) do |elves|
    elf1 = elves[0]
    elf2 = elves[1]
    elf3 = elves[2]

    common_char =
      elf1.chars.to_set
          .intersection(elf2.chars.to_set)
          .intersection(elf3.chars.to_set)

    total_sum += char_values[common_char.to_a[0]]
  end

  puts("The score for puzzle two is #{total_sum}")
end

puzzle_one
puzzle_two
