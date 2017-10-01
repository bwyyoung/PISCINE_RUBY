#!/usr/bin/env ruby -w

class Html
	attr_reader :page_name

	def initialize(filename)
		@page_name = filename
		head
	end

	def head
		raise "A file #{@page_name}.html named already exist!" if File.file?("#{@page_name}.html")
		File.open("#{@page_name}.html", 'w') { |file|
		file << "<!DOCTYPE html>\n<html>\n<head>\n<title>#{@page_name}</title>\n</head>\n<body>\n"
		}
	end

	def dump(str)
		File.open("#{@page_name}.html", 'a+') { |file|
		tab = file.readlines
		raise "Body has already been closed in #{@page_name}.html" if tab.any?{|line| line.include?("</body>")}
		raise "There is no body tag in #{@page_name}.html" if tab.none?{|line| line.include?("<body>")}
		file << "\t<p>#{str}</p>\n"
		}
	end

	def finish
		File.open("#{@page_name}.html", 'a+') { |file|
		raise "#{@page_name}.html has already been closed." if file.any?{|line| line.include?("</body>")}
		file << "</body>"
		}
	end
end
