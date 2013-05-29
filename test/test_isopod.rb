require 'test/unit'
require 'isopod'

class IsopodTest < Test::Unit::TestCase
  def test_buffer
    buf = Isopod::Buffer.new(File.open("/home/brandon/code-projects/isopod/sample.pdf","r"))
    assert_equal "%PDF-1.4", buf.token
  end
  
  def test_buffer_tokens
    buf = Isopod::Buffer.new(File.open("/home/brandon/code-projects/isopod/sample.pdf","r"))
    assert_equal ["%PDF-1.4", "1", "0"], buf.tokens(3)
  end  

  def test_buffer_reverse
    file = File.open("/home/brandon/code-projects/isopod/sample.pdf","r")
    file.seek 0, IO::SEEK_END
    buf = Isopod::Buffer.new(file)
    assert_equal "%%EOF", buf.token(:reverse=>true)

  end

  def test_buffer_reverse_tokens
    file = File.open("/home/brandon/code-projects/isopod/sample.pdf","r")
    file.seek 0, IO::SEEK_END
    buf = Isopod::Buffer.new(file)
    assert_equal ["%%EOF","408","startxref"], buf.tokens(:count=>3,:reverse=>true)

  end

  def test_buffer_peek
    buf = Isopod::Buffer.new(File.open("/home/brandon/code-projects/isopod/sample.pdf","r"))
    pos = buf.pos
    tok = buf.peek
    assert_equal "%PDF-1.4", tok
    assert_equal pos.to_i, buf.pos.to_i

  end

end
