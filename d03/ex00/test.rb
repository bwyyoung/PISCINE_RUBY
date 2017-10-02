#!/usr/bin/env ruby -w

require 'deepthought'

if $PROGRAM_NAME == __FILE__
	a = Deepthought::Deepthought.new
	a.respond("The Ultimate Question of Life, the Universe and Everything")
	a.respond("Lets have sex")
end


