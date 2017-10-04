#!/usr/bin/env ruby -w

class Html
	 attr_reader :page_name

	def initialize(filename)
	@page_name = filename
	head
	end

	def head
	  File.open("#{@page_name}.html", 'w') { |file|
		 file << "<!DOCTYPE html>\n<html>\n<head>\n<title>#{@page_name}</title>\n</head>\n<body>\n"
	  }
	end

	def dump(str)
	  File.open("#{@page_name}.html", 'a') { |file|
		  file << "\t<p>#{str}</p>\n"
	  }
	end

	def finish
	  File.open("#{@page_name}.html", 'a') { |file|
		  file << "</body>"
	  }
	end
end


if $PROGRAM_NAME == __FILE__
	a = Html.new('test_brian')
	10.times { |x| a.dump("titi_number#{x}") }
	a.finish
end