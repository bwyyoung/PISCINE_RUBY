#!/usr/bin/env ruby -w

def where
	states =
	{
		"Oregon" => "OR",
		"Alabama" => "AL",
		"New Jersey" => "NJ",
		"Colorado" => "CO"
	}
	capitals_cities =
	{
		"OR" => "Salem",
		"AL" => "Montgomery",
		"NJ" => "Trenton",
		"CO" => "Denver"
	}
	return unless ARGV.count == 1
	state = ARGV[0]
	# print "Unknown state" if  nil, when referencing a state
	# otherwise return back the proper capital city
	puts states[state].nil? ? "Unknown state" : capitals_cities[states[state]]
end

where