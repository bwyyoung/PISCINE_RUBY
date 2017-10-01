#!/usr/bin/env ruby -w

class Text
	attr_reader :str
	def initialize(str)
		@str = str
		self.to_s
	end
	def to_s
		@str
	end
end

class Elem
	attr_reader :tag, :content, :tag_type, :opt
	def initialize(tag="", content=Array[], tag_type='double',  opt={})
		@tag =  tag
		@content =  content
		@tag_type =  tag_type
		@opt = opt
	end

	def to_s
		str = to_s_tag_1(str)
		if (@content.class != String) && (@content.class != Text)
			str += "\n"
			@content.each { |value|
				str += value.to_s
				if !value.equal?(@content.last) || @content.count == 1
					str += "\n"
				end
			}
		else
			str += @content.to_s
		end
		str = to_s_opt(str)
		str = to_s_tag_2(str)
		return str
	end

	def to_s_tag_1(str)
		str = "<#{@tag}"
		if @tag_type == 'double'
			str += '>'
		end
		if !@content
			str += "\n"
		end
		return str
	end
	
	def to_s_opt(str)
		if !@opt
			@content.each do |value|
				str += value.to_s
			end
		else
			@opt.each { |k, v|
				str += " #{k}='#{v}'"
			}
		end
		return str
	end

	def to_s_tag_2(str)
		if @tag_type == 'simple'
			str += " />\n"
		elsif @tag == 'html'
			str += "\n</#{@tag}>"
		else
			str += "</#{@tag}>"
		end
		return str
	end

	def add_content(*params)
		params.each do |param|
			@content << param
		end
	end
end