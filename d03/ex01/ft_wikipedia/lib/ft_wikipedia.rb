require "ft_wikipedia/version"
require 'open-uri'
require 'Nokogiri'
require 'cgi'

# See http://blog.thepete.net/blog/2010/11/20/creating-and-publishing-your-first-ruby/
# https://stackoverflow.com/questions/11051073/declaring-a-class-within-a-module

module Ft_wikipedia
	class Ft_wikipedia

		@nb_links = 0
		@m_hash = Hash.new(0)
		@m_links =[]

		def self.finish_search
			nbr_links = @nb_links
			@nb_links = 0
			@m_hash = Hash.new(0)
			@m_links =[]
			puts '=> '+ nbr_links.to_s
			return nbr_links
		end

		def self.search(word)
		begin
			word = word.tr(' ', '_').sub(/\t/, '_')
			if @nb_links.zero?
				puts "First search @ https://en.wikipedia.org/wiki/#{word}"
				if (word.casecmp('Philosophy') == 0)
					@nb_links += 1
					return finish_search
				end
				word = "/wiki/#{word}"
			end
			word = "https://en.wikipedia.org#{word}"
			page = Nokogiri::HTML(open(word))
			@nb_links += 1
			link = page.xpath('//div[@id="mw-content-text"]//p/a[starts-with(@href, "/wiki/")]').first
			raise StandardError,  "Dead end page reached" if link.nil?
			puts "https://en.wikipedia.org#{link.attributes["href"].value}"
			@m_links << link.attributes["href"].value
			@m_hash = @m_links.inject(Hash.new(0)) do
			|m_hash, elem| m_hash[elem] += 1
			m_hash
			end
			raise StandardError, "Loop detected there is no way to philosophy here" if @m_hash.any?{|key, val| val > 1}
			if link.attributes["href"].value == "/wiki/Philosophy"
				return finish_search
			end
			self.search(link.attributes["href"].value)
		rescue StandardError => e
			 if e.message == '404 Not Found'
				puts "Dead end page reached"
			 elsif e.message == 'Loop detected there is no way to philosophy here'
				puts e.message
			 else
			 	puts e.message
			 end
		ensure
			@nb_links = 0
			@m_hash = Hash.new(0)
			@m_links =[]
		end
		end
	end
end