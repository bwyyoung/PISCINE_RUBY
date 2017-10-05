#!/usr/bin/env ruby -w

require_relative 'Ft_wikipedia.rb'

if $PROGRAM_NAME == __FILE__
	if ARGV.count == 1
		Ft_wikipedia::Ft_wikipedia.search(ARGV[0])
	end
end
