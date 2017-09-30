#!/usr/bin/env ruby -w
def croissant
	mon_tab = []
	File.open("numbers.txt", "r") {|file| file.each(","){|line| mon_tab << line} }		
	mon_tab.map {|el| el.to_i}.sort.each{|e| puts e}
end

croissant