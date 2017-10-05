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

class Page
	attr_reader :attr_elem, :classes, :body_valid_elements, :body_check, :element_textonly
	def initialize(element=Elem)
		@attr_elem = element
		@classes = [Html, Head, Body, Title, Meta, Img, Table, Th, Tr, Td, Ul, Ol, Li, H1, H2, P, Div, Span, Hr, Br]
		@body_valid_elements = [H1, H2, Div, Table, Ul, Ol, Span, Text,
								#extra stuff added in order to pass basic tests set by pdf,
								#because the pdf was not proofread when submitted.
								Img, Div, Span, Hr, Br]
		@body_check = false
		@element_textonly = [Title, H1, H2, Li, Th, Td, P]
	end

	def title_text_only?(elem)
		if elem.content&.instance_of? Text
			return true
		end
		puts 'Invalid ' + elem.content.class.name + ': it must only contain text!'
		return false
	end

	def text_string_only?(text)
		puts '-Text -> Must contains a simple string'
		if text.instance_variable_get(:@str)
			if text.str.instance_of? String
				return true
			end
		end
		puts 'Invalid Text: it must only contain a string!'
	end

	def ul_ol_isvalid?(elem)
		if element.content.instance_of? Array && element.content.length > 0
			element.content.each{|sub_element|
				unless sub_element.instance_of? Li
					puts 'Ul/Ol is invalid: contains elements other than Li'
					return false
				end
			}
			puts 'Ul/Ol is valid: contains elements that are only Li'
			return true
		end
		puts 'Ul/Ol is invalid: contains elements other than Li'
		return false
	end

	def table_isvalid?(elem)
		if element.content.instance_of? Array
			element.content.each{|sub_element|
				unless sub_element.instance_of? Tr
					puts 'Table is invalid: contains elements other than Tr'
					return false
				end
			}
			puts 'Table is valid: contains elements that are only Tr/ Table is Empty'
			return true
		end
		puts 'Table is invalid: contains elements other than Tr'
		return false
	end

	def img_isvalid?(elem)
		if elem.opt.instance_of? Hash
			if elem.opt.has_key?(:src)
				if elem.opt[:src].instance_of? Text
					puts 'Evaluating Img Text'
					if text_string_only?(elem.opt[:src])
						puts 'Img is valid: it contains src which is string'
						return true
					end
				end
			end
		end
		puts 'Img invalid: does not contain attribute src'
		return false
	end

	def tr_isvalid?(elem)
		contains_th = false
		contains_td = false
		if element.content.instance_of? Array  && element.content.length > 0
			element.content.each{|sub_elem|
				if contains_td && contains_th
					puts 'Tr is invalid: it contains both Th/Td'
					return false
				end
				if sub_elem.instance_of? Th
					contains_th = true
				elsif sub_elem.instance_of? Td
					contains_td = true
				else
					puts 'Tr is invalid: it contains element other than Th/Td'
					return false
				end
			}
			puts 'Tr is valid: contains only Th or Td'
			return true
		end
		puts 'Tr is invalid: it contains element other than Array/Array empty'
		return false
	end

	def body_valid?(element)
		if element.content.instance_of? Array
			element.content.each{| sub_element|
				is_ok = false
				@body_valid_elements.each{ |valid_body|
					if sub_element.instance_of? (valid_body)
						is_ok = true
					end
				}
				unless is_ok
					puts 'invalid element found in body!'
					return false
				end
			}
		end
		return true
	end

	def head_valid?(element)
		if (element.content.instance_of? Array) && (element.content.length == 1) &&
			(element.content.first&.instance_of? Title)
			puts 'Head is OK'
			return true
		end
		puts 'Head is NOT OK'
		return false
	end

	def html_valid?(element)
		puts '- root element of type "html"'
		puts '- Html -> Must contains a Head AND a Body after it'
		if (element.content.instance_of? Array) && (element.content.length == 2) &&
			(element.content.first&.instance_of? Head)&&
			(element.content.last&.instance_of? Body)
			return true
		end
		puts 'Html file invalid. Head/body not detected!'
		return false
	end

	def element_textonly?(element)
		@element_textonly.each{ |check_type|
			if element.instance_of? check_type
				puts 'Evaluating element that must only contain text: ' + element.class.name
				if element.content&.instance_of? Text
					if text_string_only?element.content
						puts 'Text-Only element is valid'
						return true
					end
					return false
				else
					puts 'Element is invalid: it contains content other than text'
					return false
				end
			end
		}
		return true
	end

	def span_valid?(element)
		if (element.content&.instance_of? Text) || (element.content&.instance_of? P)
			puts 'span is valid: contains only Text or P'
			return true
		end
		puts 'span invalid: contains elements other than Text or P'
		return false
	end

	def element_check?(element=Elem)
		puts 'new element check! ' + element.class.name
		if (@body_check) && !body_valid?(element)
			return false
		end
		@classes.each {|type|
			if element.instance_of? (type)
				unless element.instance_of? Body
					puts 'Currently evaluating a ' + element.class.name + ' :'
				end
				if element.instance_of? Html
					unless self.html_valid?(element)
						return false
					end
				end
				unless element_textonly?(element)
					return false
				end
				if element.content&.instance_of? Text
					a = element.content
					unless self.text_string_only?(a)
						return false
					end
				end
				if element.instance_of? Head
					unless self.head_valid?(element)
						return false
					end
				elsif element.instance_of? Body
					unless self.body_valid?(element)
						return false
					end
					@body_check = true
				elsif element.instance_of? Span
					unless self.span_valid?(element)
						return false
					end
				elsif (element.instance_of? Ul) || (element.instance_of? Ol)
					unless self.ul_ol_isvalid?(element)
						return false
					end
				elsif element.instance_of? Tr
					unless self.tr_isvalid?(element)
						return false
					end
				elsif element.instance_of? Table
					unless self.table_isvalid?(element)
						return false
					end
				elsif element.instance_of? Img
					unless self.img_isvalid?(element)
						return false
					end
				end

				if element.content.instance_of? Array
					if !(element.instance_of? Html) && !(element.instance_of? Img)
						puts 'Evaluating a multiple node'
					end
					element.content.each {|sub_element|
						unless element_check?(sub_element)
							return false
						end
					}
				end
				return true
			end
		}
		puts 'Elem is not of any subclass type'
		return false
	end


	def isvalid?()
		@body_check = false
		if element_check?(@attr_elem)
			puts "\t\t FILE IS OK"
			@body_check = false
			return true
		end
		@body_check = false
		puts "\t\t FILE IS NOT OK"
		return false
	end
end


if $PROGRAM_NAME == __FILE__
	toto = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test = Page.new(toto)
	test.isvalid?
	puts '---------------------IMG INVALID-------------------------'
	tata = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
	Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
	{}) ]) ])
	test2 = Page.new(tata)
	test2.isvalid?
	puts '----------------------NO HEAD------------------------'
	tata = Html.new(
   Body.new([H1.new(Text.new("Oh no, not again!")), Img.new([],
																			  {}) ]) )
	test2 = Page.new(tata)
	test2.isvalid?
	puts '---------------------H1 INVALID-------------------------'
	toto = Html.new([Head.new([Title.new(Text.new("Hello ground!"))]),
					 Body.new([
	H1.new(Span.new("Oh no, not again!")), Img.new([],
			{'src': Text.new('http://i.imgur.com/pfp3T.jpg')}) ]) ])
	test = Page.new(toto)
	test.isvalid?
end