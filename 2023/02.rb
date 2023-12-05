# Advent of Code 2023 - Day 2
# https://adventofcode.com/2023/day/2

# Part 1

input = File.read "inputs/02.txt"

limits = {
  r: 12,
  g: 13,
  b: 14,
}

id_sum = 0

input.each_line.with_index do |line, index|
  valid_game = true

  # gets rid of `Game n:` from the line and splits again for each round
  line.split(' ').drop(2).join(' ').split(';').each do |round|
    round.split(',').each do |cube|
      # the first word is always the digit; second word always the color
      num, color = cube.split(' ')
      num = num.to_i

      case color
        when /red/   then valid_game = false if num > limits[:r]
        when /green/ then valid_game = false if num > limits[:g]
        when /blue/  then valid_game = false if num > limits[:b]
      end

      break if !valid_game
    end

    break if !valid_game
  end

  id_sum += index + 1 if valid_game
end

puts "sum of valid ids: #{id_sum}"

# Part 2

power_sum = 0

input.each_line do |line|
  r = 0
  g = 0
  b = 0

  line.split(' ').drop(2).join(' ').split(';').each do |round|
    round.split(',').each do |cube|
      num, color = cube.split(' ')
      num = num.to_i

      case color
        when /red/   then r = num if num > r
        when /green/ then g = num if num > g
        when /blue/  then b = num if num > b
      end
    end
  end

  power_sum += r * g * b
end

puts "power sum: #{power_sum}"
