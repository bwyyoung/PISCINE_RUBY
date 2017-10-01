require 'test_helper'

class deepthoughtTest < Minitest::Test

  def test_class
    foo = deepthought::deepthought.new
    assert_kind_of(deepthought::deepthought, foo, "")
  end

  def test_respond
    foo = deepthought::deepthought.new
    question = "The Ultimate Question of Life, the Universe and Everything"
    assert_equal(foo.respond(question), "42")
    question = "LOL"
    assert_equal(foo.respond(question), "Mmmm i'm bored")
  end

  def test_that_it_has_a_version_number
    refute_nil ::deepthought::VERSION
  end
end
