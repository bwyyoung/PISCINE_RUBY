require 'test_helper'

class FtWikipediaTest < Minitest::Test
	def test_version_number
		puts '------------------------ test_version_number ------------------------'
		refute_nil ::FtWikipedia::VERSION
		puts '------------------------ test_version_number END------------------------'
	end

	def test_running
		puts '------------------------ test_running ------------------------'
		assert true
		puts '------------------------ test_running END------------------------'
	end

	def test_kiss
		puts '------------------------ test_kiss ------------------------'
		assert_equal 16, Ft_Wikipedia.search("Kiss"),
				 'test Kiss'
		puts '------------------------ test_kiss END------------------------'
	end

	def test_road_to_philosophy
		puts '------------------------ test_it_road_to_Philosophy ------------------------'
		assert_output (/Philosophy/) { Ft_Wikipedia.search("Philosophy") }
		assert_output (/Philosophy/) { Ft_Wikipedia.search("kiss") }
		assert_output (/Philosophy/) { Ft_Wikipedia.search("Einstein") }
		puts '------------------------ test_it_road_to_Philosophy END------------------------'
	end

	def test_loops
		puts '------------------------ Loop Test ------------------------'
		assert_nil Ft_Wikipedia.search("France")
		puts '------------------------ Loop Test End------------------------'
	end

	def test_dead_end
		puts '------------------------ Dead End Test ------------------------'
		assert_nil Ft_Wikipedia.search("fdasrfes3arfaesf")
		puts '------------------------ Dead End Test End------------------------'
	end

end
