#!/usr/bin/env ruby -w

def whereto
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
	states_inv = states.invert
	cc_inv = capitals_cities.invert
	# return if argument is not string
	return unless ARGV.count == 1 && ARGV[0].class == "".class
	# split elements by comma and capitalize them in an array
	arg_elements = ARGV[0].split(",").map{|item| item.strip}
	arg_elements.each {
	|elem|
		if states.has_key?(elem.capitalize)
			puts "#{capitals_cities[states[elem.capitalize]]} is the capital of #{elem.capitalize} (akr: #{states[elem.capitalize]})"
		elsif cc_inv.has_key?(elem.capitalize)
			puts "#{elem.capitalize} is the capital of #{states_inv[cc_inv[elem.capitalize]]} (akr: #{cc_inv[elem.capitalize]})"
		else
			puts "#{elem.downcase} is neither a capital city nor a state" unless elem.empty?
		end
	}
end

whereto