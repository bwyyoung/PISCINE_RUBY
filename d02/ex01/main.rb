#!/usr/bin/env ruby -w

require_relative 'ex01.rb'

if $PROGRAM_NAME == __FILE__
	a = Html.new("test")
	10.times{|x| a.dump("titi_number#{x}")}
	a.finish

	b = Html.new("test2")
	10.times{|x| b.dump("titi_number#{x}")}
	b.finish
	b.dump "test again"

	c = Html.new("test2")
	c.finish
end