# Advent of Code 2015 - Day 2
# https://adventofcode.com/2015/day/2

# Part 1

with open("inputs/02.txt") as input:
	total = 0

	for line in input.readlines():
		nums = list(map(int, line.split("x")))

		lw = nums[0] * nums[1]
		wh = nums[1] * nums[2]
		hl = nums[2] * nums[0]
		total += 2 * (lw + wh + hl) + min(lw, wh, hl)

	print(total)

# Part 2

with open("inputs/02.txt") as input:
	total = 0

	for line in input.readlines():
		nums = sorted(map(int, line.split("x")))
		total += 2 * (nums[0] + nums[1]) + nums[0] * nums[1] * nums[2]

	print(total)
