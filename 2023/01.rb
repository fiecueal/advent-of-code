# Advent of Code 2023 - Day 1
# https://adventofcode.com/2023/day/1

# Part 1

input = File.read "inputs/01.txt"

total = 0

input.each_line do |line|
  nums = line.scan /[0-9]/
  val = "#{nums.first}#{nums.last}"
  total += val.to_i
end

puts "calibration sum: #{total}"

# Part 2

def intify num_string
  case num_string
    when "one",   "on"   then "1"
    when "two",   "tw"   then "2"
    when "three", "thre" then "3"
    when "four"          then "4"
    when "five",  "fiv"  then "5"
    when "six"           then "6"
    when "seven", "seve" then "7"
    when "eight", "eigh" then "8"
    when "nine",  "nin"  then "9"
    # return num_string if already represented as int
    else num_string
  end
end

total = 0

input.each_line do |line|
  # digits, edge cases where words overlap, full words
  nums = line.scan /[0-9]|
                    on(?=eight)|tw(?=one)|thre(?=eight)|
                    fiv(?=eight)|seve(?=nine)|eigh(?=two)|
                    eigh(?=three)|nin(?=eight)|
                    one|two|three|four|five|six|seven|eight|nine/x
  val = "#{intify nums.first}#{intify nums.last}"
  total += val.to_i
end

puts "calibration sum(Part 2): #{total}"
