require 'test_helper'

class Ft_wikipediaTest < Minitest::Test

  def test_42
    foo = Ft_wikipedia::Ft_wikipedia.new
    foo.search("42")
  end

  def test_class
    foo = Ft_wikipedia::Ft_wikipedia.new
    assert_kind_of(Ft_wikipedia::Ft_wikipedia, foo, "")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ft_wikipedia::VERSION
  end

end
