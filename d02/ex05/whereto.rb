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
	def initialize(content=String, opt={})
		super("Title", Text.new(content), 'double', opt)
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
	def initialize(content=String, opt={})
		super("H1", Text.new(content), 'double', opt)
	end
end

class H2 < Elem
	def initialize(content=String, opt={})
		super("H2", Text.new(content), 'double', opt)
	end
end

class P < Elem
	def initialize(content=String, opt={})
		super("H2", Text.new(content), 'double', opt)
	end
end

class Div < Elem
	def initialize(content=Array[], opt={})
		super("Div", content, 'double', opt)
	end
end

class Span < Elem
	def initialize(content=String, opt={})
		super("Span", Text.new(content), 'double', opt)
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

class Page
	attr_reader :attr_elem
	def initialize(element=Elem)
		@attr_elem = element
	end
	def typecheck()
		if @attr_elem.instance_of? Elem
			puts 'Elem is not of any subclass type'
			return false
		end

		return false
	end

	def check_valid()
		if typecheck()
			return true
		end
		return false
	end

	def isvalid?()
		if @attr_elem.instance_of? Html
			puts 'Currently evaluating a Html :'
		end
		check_valid
	end
end


if $PROGRAM_NAME == __FILE__
	toto = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test = Page.new(toto)
	test.isvalid?
	tata = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test2 = Page.new(tata)
	test2.isvalid?
end