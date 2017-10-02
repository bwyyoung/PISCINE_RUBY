require "deepthought/version"

require 'colorize'

# See http://blog.thepete.net/blog/2010/11/20/creating-and-publishing-your-first-ruby/
# https://stackoverflow.com/questions/11051073/declaring-a-class-within-a-module
module Deepthought
	class Deepthought
		def initialize
		end
		def respond(question)
			if question == "The Ultimate Question of Life, the Universe and Everything"
				puts "42".green
				return "42"
			else
				puts "Mmmm i'm bored".red
				return "Mmmm i'm bored"
			end
		end
	end
end