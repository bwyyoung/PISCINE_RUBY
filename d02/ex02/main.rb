#!/usr/bin/env ruby -w

require_relative 'ex02.rb'

if $PROGRAM_NAME == __FILE__
	a = Html.new('mireille')
	10.times{|x| a.dump("titi_number#{x}")}
	a.finish
	a.dump("test was here")
end

