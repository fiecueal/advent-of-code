# Advent of Code 2023 - Day 5
# https://adventofcode.com/2023/day/5

# Part 1

input = File.read "inputs/05.txt"

def new_map line
  dest, source, range = line.split(' ').map(&:to_i)
  { dest: dest, source: source, range: range }
end

def new_val source_val, maps
  dest_val = source_val
  maps.each do |map|
    if map[:source] <= source_val && source_val <= map[:source] + map[:range]
      dest_val = source_val + map[:dest] - map[:source]
    end
  end

  dest_val
end

# hash of arrays of ints
vals = {
  seed: [],
  soil: [],
  fertilizer: [],
  water: [],
  light: [],
  temp: [],
  humidity: [],
  location: [],
}
# hash of arrays of hashes with { dest, source, range }
maps = {
  soil: [],
  fertilizer: [],
  water: [],
  light: [],
  temp: [],
  humidity: [],
  location: [],
}

current_maps = nil

input.each_line do |line|
  case line
  when /seeds:/        then vals[:seed] = line.split(' ').drop(1).map(&:to_i)
  when /to-soil/       then current_maps = maps[:soil]
  when /to-fertilizer/ then current_maps = maps[:fertilizer]
  when /to-water/      then current_maps = maps[:water]
  when /to-light/      then current_maps = maps[:light]
  when /to-temp/       then current_maps = maps[:temp]
  when /to-humidity/   then current_maps = maps[:humidity]
  when /to-location/   then current_maps = maps[:location]
  when /^\d/           then current_maps << new_map(line)
  end
end

vals[:seed].each do |seed|
  vals[:soil]       << new_val(seed,                   maps[:soil])
  vals[:fertilizer] << new_val(vals[:soil].last,       maps[:fertilizer])
  vals[:water]      << new_val(vals[:fertilizer].last, maps[:water])
  vals[:light]      << new_val(vals[:water].last,      maps[:light])
  vals[:temp]       << new_val(vals[:light].last,      maps[:temp])
  vals[:humidity]   << new_val(vals[:temp].last,       maps[:humidity])
  vals[:location]   << new_val(vals[:humidity].last,   maps[:location])
end

puts "lowest location number: #{vals[:location].min}"

# Part 2

def new_val_range sources, maps
  soil_map.each do |map|
    # if sources overlaps to the left of map
    # source range          |---------------|
    # map range                 |--------------|
    # lowest value -----------> ^
    if seed_range.first <= map[:source] &&
       seed_range.last  >= map[:source]
      puts "heheheh"
      return [map[:dest], seed_range.first]

    # if seed_range overlaps to the right of map
    # seed_range           |---------------|
    # soil map range    |--------------|
    # lowest value ------> ^
    elsif seed_range.first >  map[:source] &&
          seed_range.first <= map[:source] + map[:range]
      puts "hahahaha"
      return [map[:dest] + seed_range.first - map[:source]]
    end
  end
end

vals.each_value do |v|
  v.clear
end

temp_seed = input.lines.first.split(' ').drop(1).map(&:to_i)
(temp_seed.size / 2).times do |i|
  vals[:seed] << [temp_seed[i * 2], temp_seed[i * 2] + temp_seed[i * 2 + 1]]
end

vals[:seed].each do |seed|
  vals[:soil]       += new_val_range(seed,                   maps[:soil])
  vals[:fertilizer] << new_val_range(vals[:soil].last,       maps[:fertilizer])
  vals[:water]      << new_val_range(vals[:fertilizer].last, maps[:water])
  vals[:light]      << new_val_range(vals[:water].last,      maps[:light])
  vals[:temp]       << new_val_range(vals[:light].last,      maps[:temp])
  vals[:humidity]   << new_val_range(vals[:temp].last,       maps[:humidity])
  vals[:location]   << new_val_range(vals[:humidity].last,   maps[:location])
end

puts "lowest location number with seed ranges: #{vals[:location].min}"

# wrong 155557532
