# Advent of Code 2015 - Day 1
# https://adventofcode.com/2015/day/1

# Part 1

with open("inputs/01.txt") as input:
	floor = 0

	for paren in input.read():
		if paren == "(":
			floor += 1
		else:
			floor -= 1

	print(floor)

# Part 2

with open("inputs/01.txt") as input:
	floor = 0

	for i, paren in enumerate(input.read()):
		if paren == "(":
			floor += 1
		else:
			floor -= 1

		if floor == -1:
			print(i + 1) # santa starts at floor 1
			break
