require "ft_wikipedia/version"
require 'open-uri'
require 'Nokogiri'

# See http://blog.thepete.net/blog/2010/11/20/creating-and-publishing-your-first-ruby/
# https://stackoverflow.com/questions/11051073/declaring-a-class-within-a-module

module Ft_Wikipedia
	class Ft_Wikipedia

		@@nb_links = 0
		@@m_hash = Hash.new(0)
		@@m_links =[]

		def self.search(word)
		begin
			if @@nb_links.zero?
			puts "First search @ https://en.wikipedia.org/wiki/#{word}"
			word = "/wiki/#{word}"
			end
			page = Nokogiri::HTML(open("https://en.wikipedia.org#{word}"))
			@@nb_links += 1
			link = page.xpath("//div[@id='mw-content-text']/p/a[starts-with(@href, '/wiki/')]").first
			raise StandardError,  "Dead end page reached" if link.nil?
			puts "https://en.wikipedia.org#{link.attributes["href"].value}"
			@@m_links << link.attributes["href"].value
			@@m_hash = @@m_links.inject(Hash.new(0)) do
			|m_hash, elem| m_hash[elem] += 1
			m_hash
			end
			raise StandardError, "Loop detected there is no way to philosophy here" if @@m_hash.any?{|key, val| val > 1}
			if link.attributes["href"].value == "/wiki/Philosophy"
			nbr_links = @@nb_links
			@@nb_links = 0
			@@m_hash = Hash.new(0)
			@@m_links =[]
			return nbr_links
			end
			self.search(link.attributes["href"].value)

		rescue StandardError => e
			 if e.message == '404 Not Found'
				puts "Dead end page reached"
			 elsif e.message == 'Loop detected there is no way to philosophy here'
				puts e.message
			 else
			 	raise e
			 end
		ensure
			@@nb_links = 0
			@@m_hash = Hash.new(0)
			@@m_links =[]
		end
		end
	end
end