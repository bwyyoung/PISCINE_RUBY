require 'test_helper'

class DeepthoughtTest < Minitest::Test

  def test_class
    foo = Deepthought::Deepthought.new
    assert_kind_of(deepthought::deepthought, foo, "")
  end

  def test_respond
    foo = Deepthought::Deepthought.new
    question = "The Ultimate Question of Life, the Universe and Everything"
    assert_equal(foo.respond(question), "42")
    question = "LOL"
    assert_equal(foo.respond(question), "Mmmm i'm bored")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Deepthought::VERSION
  end
end
#