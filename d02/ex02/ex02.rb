#!/usr/bin/env ruby -w

class Body_closed < StandardError
	attr_reader :page_name

	def initialize(page_name)
		@page_name = page_name
	end

	def show_state
		puts "In #{@page_name}.html body was closed."
	end

	def correct
		puts "correcting error"
		tmp = []
		File.open("#{@page_name}.html", "r") do |file|
			file.each_with_index do |line, nb_line|
				tmp << line unless line.include? "</body>"
				@num_line = nb_line + 1
			end
		end
		File.open("#{@page_name}.html", 'w') do |file|
			tmp.each {|line| file << line }
		end
	end

	def explain
		puts "> ln :#{@num_line} </body> : text has been inserted and tag moved at the end of it."

	end
end

class Dup_file < StandardError
	attr_reader :page_name

	def initialize(page_name)
		@page_name = page_name
	end

	def show_state
		path = File.expand_path @page_name + ".html"
		puts "A file named #{@page_name} was already there: #{path}"
	end

	def correct
	@new_file = @page_name + ".new"
		begin
			raise error = Dup_file.new(@new_file) if File.file? "#{@new_file}.html"
		rescue => error
				@new_file = error.correct
		end
		File.open("#{@new_file}.html", 'w+')
		@new_file
	end

	def explain
	new_file_path = File.expand_path("#{@new_file}.html")
	puts "Appended .new in order to create requested file: #{new_file_path}"
	end
end


class Html
	attr_reader :page_name

	def initialize(filename)
		@page_name = filename
		head
	end

	def head
		if File.file?("#{@page_name}.html")
			begin
				raise custom_ex = Dup_file.new(@page_name)
			rescue => custom_ex
				custom_ex.show_state
				@page_name = custom_ex.correct
				custom_ex.explain
			end
		end	
		File.open("#{@page_name}.html", 'w') do |file|
			file << "<!DOCTYPE html>\n<html>\n<head>\n<title>#{@page_name}</title>\n</head>\n<body>\n"
		end
	end

	def dump(str)
		File.open("#{@page_name}.html", 'a+') do |file|
			line_list = file.readlines
			if line_list.any?{|line| line.include?("</body>")}
				begin
					raise custom_ex = Body_closed.new(@page_name)
				rescue => custom_ex
					custom_ex.show_state
					custom_ex.correct
					custom_ex.explain
					file << "\t<p>#{str}</p>\n"
					file << "</body>\n"
					return
				end
			end			
			raise "There is no body tag in #{@page_name}.html" if line_list.none?{|line| line.include?('<body>')}
			file << "\t<p>#{str}</p>\n"
		end
	end

	def finish
		File.open("#{@page_name}.html", 'a+') do |file|
			raise "#{@page_name}.html has already been closed." if file.any?{|line| line.include?("</body>")}
			file << "</body>\n"
		end
	end
	
end

if $PROGRAM_NAME == __FILE__
	a = Html.new('mireille')
	10.times{|x| a.dump("titi_number#{x}")}
	a.finish
	a.dump("test was here")
end

