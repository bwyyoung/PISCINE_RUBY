#!/usr/bin/env ruby -w

def erehW
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
	capital = ARGV[0]
	cc_inv = capitals_cities.invert
	puts cc_inv[capital].nil? ? "Unknown capital city" : states.invert[cc_inv[capital]]
end

if $PROGRAM_NAME == __FILE__
	erehW
end