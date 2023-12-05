# Advent of Code 2023 - Day 4
# https://adventofcode.com/2023/day/4

# Part 1

input = File.read "inputs/04.txt"

total_points = 0

input.each_line do |line|
  win_nums, my_nums = line.split(' ').drop(2).join(' ').split('|')
  win_nums = win_nums.split(' ')
  my_nums = my_nums.split(' ')

  line_points = 0
  win_nums.each do |win_num|
    my_nums.each do |my_num|
      if win_num == my_num
        if line_points.zero? then line_points = 1
        else line_points *= 2
        end
      end
    end
  end

  total_points += line_points
end

puts "total points: #{total_points}"

# Part 2

total_scratchcards = 0
copies = {}

input.each_line.with_index do |line, i|
  win_nums, my_nums = line.split(' ').drop(2).join(' ').split('|')
  win_nums = win_nums.split(' ')
  my_nums = my_nums.split(' ')

  matches = 0
  win_nums.each do |win_num|
    my_nums.each do |my_num|
      if win_num == my_num
        matches += 1
      end
    end
  end

  copies[i] ||= 1
  copies[i].times do
    total_scratchcards += 1

    matches.times do |j|
      copies[i + 1 + j] ||= 1
      copies[i + 1 + j]  += 1
    end
  end
end

puts "total scratchcards: #{total_scratchcards}"
