# A and X = rock
# B and Y = paper
# C and Z = scissors
def calculate_score(rps_input)
  score_for_shape = { 'X' => 1, 'Y' => 2, 'Z' => 3 }
  beats = { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
  draws = { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' }
  total_score = 0
  rps_input.each do |input|
    total_score += 3 if draws[input[0]] == input[2]
    total_score += 6 if beats[input[0]] == input[2]
    total_score += score_for_shape[input[2]]
  end

  total_score
end

def puzzle_one
  file = File.read('./input.txt')
  total_score = calculate_score(file.lines)

  puts("The total score for puzzle one would be: #{total_score}")
end

# X = Loss
# Y = Draw
# Z = Win
def convert_input_into_rps(result_input)
  convert_loss = { 'A' => 'Z', 'B' => 'X', 'C' => 'Y' }
  convert_draws = { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' }
  convert_beats = { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }

  result_input.map do |line_input|
    case line_input[2]
    when 'X'
      line_input[2] = convert_loss[line_input[0]]
    when 'Y'
      line_input[2] = convert_draws[line_input[0]]
    when 'Z'
      line_input[2] = convert_beats[line_input[0]]
    end
    line_input
  end
end

def puzzle_two
  file = File.read('./input.txt')
  rps_input = convert_input_into_rps(file.lines)
  total_score = calculate_score(rps_input)

  puts("The total score for puzzle two would be: #{total_score}")
end

puzzle_one
puzzle_two
