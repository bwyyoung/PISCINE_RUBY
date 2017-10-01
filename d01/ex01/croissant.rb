#!/usr/bin/env ruby -w

def croissant
		number_set = []
		File.open('numbers.txt', 'r') {|file| file.each(','){|line| number_set << line}}
		number_set.map {|el| el.to_i}.sort.each{|e| puts e}
end

if $PROGRAM_NAME == __FILE__
	croissant
end