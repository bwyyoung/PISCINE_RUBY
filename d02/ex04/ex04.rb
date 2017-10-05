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
		@tag = tag
		@content = content
		@tag_type = tag_type
		@opt = opt
	end

	def to_s
		str = to_s_tag_1(str)
		if (@content.class != String) && (@content.class != Text)
			if @tag_type != 'simple'
				str += "\n"
			end
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
		elsif @tag.downcase == 'html'
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

class Html < Elem
	def initialize(content=Array[], opt={})
		super("Html", content, 'double', opt)
	end
end

class Head < Elem
	def initialize(content=Array[], opt={})
		super("Head", content, 'double', opt)
	end
end

class Body < Elem
	def initialize(content=Array[], opt={})
		super("Body", content, 'double', opt)
	end
end

class Title < Elem
	def initialize(content, opt={})
		super("Title", content, 'double', opt)
	end
end

class Meta < Elem
	def initialize(content=Elem, opt={})
		super("Meta", [content], 'simple', opt)
	end
end

class Img < Elem
	def initialize(content=Array[], opt={})
		super("Img", content, 'simple', opt)
	end
end

class Table < Elem
	def initialize(content=Array[], opt={})
		super("Table", content, 'double', opt)
	end
end

class Th < Elem
	def initialize(content=Array[], opt={})
		super("Th", content, 'double', opt)
	end
end

class Tr < Elem
	def initialize(content=Array[], opt={})
		super("Tr", content, 'double', opt)
	end
end

class Td < Elem
	def initialize(content=Array[], opt={})
		super("Td", content, 'double', opt)
	end
end

class Ul < Elem
	def initialize(content=Array[], opt={})
		super("Ul", content, 'double', opt)
	end
end

class Ol < Elem
	def initialize(content=Array[], opt={})
		super("Ol", content, 'double', opt)
	end
end

class Li < Elem
	def initialize(content=Array[], opt={})
		super("Li", content, 'double', opt)
	end
end

class H1 < Elem
	def initialize(content, opt={})
		super("H1", content, 'double', opt)
	end
end

class H2 < Elem
	def initialize(content, opt={})
		super("H2", content, 'double', opt)
	end
end

class P < Elem
	def initialize(content, opt={})
		super("P", content, 'double', opt)
	end
end

class Div < Elem
	def initialize(content=Array[], opt={})
		super("Div", content, 'double', opt)
	end
end

class Span < Elem
	def initialize(content, opt={})
		super("Span", content, 'double', opt)
	end
end

class Hr < Elem
	def initialize(opt={})
		super("Hr", [], 'simple', opt)
	end
end

class Br < Elem
	def initialize(opt={})
		super("Br", [], 'simple', opt)
	end
end


if $PROGRAM_NAME == __FILE__
	puts Html.new([Head.new([Title.new("Hello ground!")]),
				   Body.new([H1.new("Oh no, not again!"),
							 Img.new([], {'src':'http://i.imgur.com/pfp3T.jpg'}) ]) ])
end