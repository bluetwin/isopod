require 'test/unit'
require 'isopod'

class IsopodTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal "hello world", Isopod.hi("english")
  end

  def test_any_hello
    assert_equal "hello world", Isopod.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "hola mundo", Isopod.hi("spanish")
  end
  
  def test_trailer
    assert_equal "", Isopod.trailer(File.open("/home/brandon/code/isopod/PDF32000_2008.pdf","r"))
  end
 
end
