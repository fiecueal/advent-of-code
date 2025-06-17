# Advent of Code 2015 - Day 1
# https://adventofcode.com/2015/day/1

input = File.read 'inputs/01.txt'

# Part 1

floor = 0

input.each_char do |paren|
  floor += if paren == '('
             1
           else
             -1
           end
end

puts floor

# Part 2

floor = 0

input.each_char.with_index(1) do |paren, i|
  floor += if paren == '('
             1
           else
             -1
           end

  break puts(i) if floor == -1
end
