#!/usr/bin/env ruby -w

def coffeecroissant
	data = [
		['Frank', 33],
		['Stacy', 15],
		['Juan' , 24],
		['Dom' , 32],
		['Steve', 24],
		['Jill', 24]
	]
	# sort by age, then by name, and then for each element, print the first of the 2 elements
	data.sort_by{ |name, age| [age, name] }.each{|element| puts element.first}
end
coffeecroissant