require_relative 'test_helper.rb'

class FtWikipediaTest < Minitest::Test


	def test_road_to_philosophy
		puts '------------------------ test_Road_to_Philosophy ------------------------'
		begin
		m_wiki = Ft_wikipedia::Ft_wikipedia
		m_wiki.search('42 (number)')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('Philosophy')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('directory')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('problem')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('einstein')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('kiss')
		rescue => error
		end
		puts '----------'
		begin
		m_wiki.search('matter')
		rescue => error
		end
		puts '----------'
		begin
			m_wiki.search('Sex')
		rescue => error
		end
		puts '----------'
		begin
			m_wiki.search('Filthy Frank')
		rescue => error
		end
		assert_output (/Philosophy/) { m_wiki.search('Philosophy') }
		assert_output (/Philosophy/) { m_wiki.search('Filthy Frank') }
		assert_output (/Philosophy/) { m_wiki.search('Sex') }
		puts '------------------------ test_Road_to_Philosophy END------------------------'
	end

	def test_loops
		puts '------------------------ Loop Test ------------------------'
		m_wiki = Ft_wikipedia::Ft_wikipedia
		assert_nil m_wiki.search('France')
		puts '------------------------ Loop Test End------------------------'
	end

	def test_dead_end
		puts '------------------------ Dead End Test ------------------------'
		m_wiki = Ft_wikipedia::Ft_wikipedia
		assert_nil m_wiki.search('fdasrfes3arfaesf')
		puts '------------------------ Dead End Test End------------------------'
	end
	def test_class
		puts '--test_class--'
		m_deepthought = Ft_wikipedia::Ft_wikipedia.new
		assert_kind_of(Ft_wikipedia::Ft_wikipedia, m_deepthought,
					   'Deepthought Object Not Matched')
		puts '--test_class END--'
	end
	def test_version_number
		puts '------------------------ test_version_number ------------------------'
		refute_nil ::Ft_wikipedia::VERSION
		puts 'VERSION NUMBER OK: ' + Ft_wikipedia::VERSION
		puts '------------------------ test_version_number END------------------------'
	end

	def test_running
		puts '------------------------ test_running ------------------------'
		assert true
		puts '------------------------ test_running END------------------------'
	end
end
