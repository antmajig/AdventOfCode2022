def puzzle_one
  file = File.read('./input.txt')
  cover_count = 0
  file.lines.each do |line|
    input = line.split(',')
    elf1 = input[0].split('-')
    elf2 = input[1].split('-')
    a_covers_b = (elf1[0].to_i..elf1[1].to_i).cover?(elf2[0].to_i..elf2[1].to_i)
    b_covers_a = (elf2[0].to_i..elf2[1].to_i).cover?(elf1[0].to_i..elf1[1].to_i)

    cover_count += 1 if a_covers_b || b_covers_a
  end
  puts("Answer to puzzle one is #{cover_count}")
end

def puzzle_two
  file = File.read('./input.txt')
  cover_count = 0
  file.lines.each do |line|
    input = line.split(',')
    elf1 = input[0].split('-').map(&:to_i)
    elf2 = input[1].split('-').map(&:to_i)

    # initialise hash of range min-max
    elf_hash = {}
    ((elf1 + elf2).min..(elf1 + elf2).max).to_a.each { |i| elf_hash[i] = 0 }

    # increment hash value by one for each elf range
    (elf1[0]..elf1[1]).each do |n|
      elf_hash[n] += 1
    end
    (elf2[0]..elf2[1]).each do |n|
      elf_hash[n] += 1
    end

    # if hash contains a value of 2 then the ranges intersect.
    cover_count += 1 if elf_hash.value?(2)
  end
  puts("Answer to puzzle two is #{cover_count}")
end

puzzle_one
puzzle_two
