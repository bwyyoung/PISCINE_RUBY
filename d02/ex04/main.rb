#!/usr/bin/env ruby -w

require_relative 'ex04.rb'

if $PROGRAM_NAME == __FILE__
	puts Html.new([Head.new([Title.new("Hello ground!")]),
				   Body.new([H1.new("Oh no, not again!"),
							 Img.new([], {'src':'http://i.imgur.com/pfp3T.jpg'}) ]) ])
end

