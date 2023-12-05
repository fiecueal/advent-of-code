# Advent of Code 2023 - Day 3
# https://adventofcode.com/2023/day/3

# Part 1

input = File.read "inputs/03.txt"

parts_sum = 0
prev_nums = [] # values, positions, bool if added to sum already or not
prev_syms = [] # positions of previous symbols

#############################################
# $~ is equivalent to Regexp.last_match
# MatchData#offset(n) returns the start and end position of the match within the string as an array
#############################################

input.each_line do |line|
  curr_nums = []
  line.scan /\d+/ do |num|
    curr_nums << {
      val: num,
      # create a range from the first position of a number to the last with an offset from the left for diagonals
      pos: ($~.offset(0)[0] - 1)..($~.offset(0)[1]),
      added: false
    }
  end

  curr_syms = []
  line.scan /[^\.|0-9|\s]/ do |sym|
    curr_syms << $~.offset(0)[0]
  end

  all_nums = curr_nums + prev_nums
  all_syms = curr_syms + prev_syms

  # puts "line #{line}"
  # puts "nums #{nums}"
  # puts "prev #{prev_syms}"
  # puts "curr #{curr_syms}"
  # puts "all #{all_syms}"

  all_nums.each do |num|
    adjacent = false

    all_syms.each do |sym|
      # puts "#{num} | #{sym}"
      if num[:pos] === sym
        adjacent = true
        break
      end
    end

    if !num[:added] && adjacent
      parts_sum += num[:val].to_i
      num[:added] = true
      # puts "#{parts_sum}"
    end
  end

  prev_nums = curr_nums
  prev_syms = curr_syms

  # gets
end

puts "parts sum: #{parts_sum}"

# Part 2

gears_sum = 0
prev_nums = [] # positions and values
prev_syms = [] # positions and adjacent numbers

input.each_line do |line|
  curr_nums = []
  line.scan /\d+/ do |num|
    curr_nums << {
      val: num,
      pos: ($~.offset(0)[0] - 1)..($~.offset(0)[1]),
    }
  end

  curr_syms = []
  line.scan /\*/ do |sym|
    curr_syms << {
      pos: $~.offset(0)[0],
      adjacents: []
    }
  end

  all_nums = curr_nums + prev_nums
  all_syms = curr_syms + prev_syms

  all_nums.each do |num|
    all_syms.each do |sym|
      if num[:pos] === sym[:pos]
        sym[:adjacents] << num unless sym[:adjacents].include? num
      end
    end
  end

  prev_syms.each do |sym|
    next unless sym[:adjacents].size == 2

    val1 = sym[:adjacents][0][:val]
    val2 = sym[:adjacents][1][:val]

    gears_sum += val1.to_i * val2.to_i
  end

  prev_nums = curr_nums
  prev_syms = curr_syms
end

puts "gears sum: #{gears_sum}"
