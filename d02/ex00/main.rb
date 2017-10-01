#!/usr/bin/env ruby -w

require_relative 'ex00.rb'

if $PROGRAM_NAME == __FILE__
	 a = Html.new('test_brian')
	 10.times { |x| a.dump("titi_number#{x}") }
	 a.finish
end
