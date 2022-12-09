def puzzle_one
  file = File.read('./input.txt')
  file = file.split("")
  index = 0
  while file.length > 4
    p file[0..3].uniq
    if file[0..3].uniq.length == 4
      puts("The answer to puzzle_one is #{index+4}")
      return nil
    end
    file.shift
    index += 1
  end
end

def puzzle_two
  file = File.read('./input.txt')
  file = file.split("")
  index = 0
  while file.length > 14
    p file[0..13].uniq
    if file[0..13].uniq.length == 14
      puts("The answer to puzzle_two is #{index+14}")
      return nil
    end
    file.shift
    index += 1
  end
end

puzzle_one
puzzle_two
