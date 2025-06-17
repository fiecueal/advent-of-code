# Advent of Code 2015 - Day 3
# https://adventofcode.com/2015/day/3

# Part 1

with open("inputs/03.txt") as input:
	giftees = 1
	houses = {0: {0: 1}}
	x = 0
	y = 0

	for dir in input.read():
		match dir:
			case "^": y += 1
			case "v": y -= 1
			case ">": x += 1
			case "<": x -= 1

		if x not in houses: houses[x] = {}
		if y not in houses[x]: houses[x][y] = 0
		houses[x][y] += 1
		if houses[x][y] == 1: giftees += 1

	print(giftees)

# Part 2

with open("inputs/03.txt") as input:
	giftees = 1
	houses = {0: {0: 2}}
	x = [0, 0]
	y = [0, 0]

	for i, dir in enumerate(input.read()):
		j = i % 2
		match dir:
			case "^": y[j] += 1
			case "v": y[j] -= 1
			case ">": x[j] += 1
			case "<": x[j] -= 1

		if x[j] not in houses: houses[x[j]] = {}
		if y[j] not in houses[x[j]]: houses[x[j]][y[j]] = 0
		houses[x[j]][y[j]] += 1
		if houses[x[j]][y[j]] == 1: giftees += 1

	print(giftees)
