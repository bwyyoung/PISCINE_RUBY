#!/usr/bin/env ruby -w



def puts_begin_html

	html_content =
<<BEGINHTML
<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>Periodic Table</title>
  <style>
	body 
	{ 
		background: url("http://cdn.uploadvr.com/wp-content/uploads/2016/07/rick-and-morty-wallpaper-1024x576.jpg") no-repeat center center fixed; 
		-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;
	}
	h1
	{   
	  text-align: center;
	  color: black;
	  background-color: yellow;
	  border-color: black;
	  border: 2px solid;
	  border-radius: 3px;
	}
	table {	width: 100%;} td {border: 1px solid black; padding:10px} 
  </style>
</head>
<body>
  <h1>Periodic Table of Elements</h1>
BEGINHTML
	File.write('periodic_table.html', html_content)
end


def puts_end_html
	html_content =
<<ENDHTML

</body>
</html>
ENDHTML
	File.write('periodic_table.html', html_content, File.size('periodic_table.html'), mode: 'a')
end

def put_table_in_file
	arr_elements = []
	number_set = File.open('periodic_table.txt', 'r'){
		|file| file.readlines.collect{
			|line|
			line.chomp
		}
	}

	for line in number_set
		my_dict = {}
		first_split = line.split('=')
	#	puts first_split.at(0)
	#	puts first_split.at(1)

		my_dict['name'] = first_split.at(0).tr(' ', '')
		second_split = first_split.at(1).split(',')
		for data in second_split
			third_split = data.split(':')
			my_dict[third_split.at(0).tr(' ', '')] = third_split.at(1).tr(' \n', '')
		end
		arr_elements.push(my_dict)
	end
	previous = 0
	s = "<table>"
	for elem in arr_elements
		current = (elem['position']).to_i
		if current == 0
			s += "<tr>"
		end
		if (current - previous) > 1
			s += "<td colspan='" + (current - previous - 1).to_s + "'></td>"
		end
		s += "<td><h4>" + elem['name'] + "</h4>"
		s += "<ul><li>" + elem['number'] + "</li><li>" + elem['small'] + "</li><li>" + elem['molar'] + "</li></ul></td>"
		if current == 17
			s += "</tr>"
			current = 0
		end
		previous = current
	end
	s += "</table>"
	File.write('periodic_table.html', s, File.size('periodic_table.html'), mode: 'a')
end

def elm(args)
	puts_begin_html
	put_table_in_file
	puts_end_html
end

elm(ARGV)
