require_relative 'test_helper.rb'

class DeepthoughtTest < Minitest::Test

  def test_class
	puts '--test_class--'
	m_deepthought = Deepthought::Deepthought.new
	assert_kind_of(Deepthought::Deepthought, m_deepthought,
				   "Deepthought Object Not Matched")
	puts '--test_class END--'
  end

  def test_respond
	puts '--test_respond--'
	m_deepthought = Deepthought::Deepthought.new
	question = "The Ultimate Question of Life, the Universe and Everything"
	assert_equal(m_deepthought.respond(question), "42")
	question = "Can I have some pussi pls?"
	assert_equal(m_deepthought.respond(question), "Mmmm i'm bored")
	puts '--test_respond END--'
  end

  def test_version_number
	  puts '--test_version_number--'
	  refute_nil ::Deepthought::VERSION
	  puts 'VERSION NUMBER OK: ' + Deepthought::VERSION
	  puts '--test_version_number END--'
  end
end
#