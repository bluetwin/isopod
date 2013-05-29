class Isopod::XrefEntry
  attr_reader :offset, :gen, :keyword, :object

  def initialize(buf)
    @buffer     = buf
    @object     = nil
    parse
  end

  def parse
      @offset, @gen, @keyword = @buffer.tokens(3)
      load_object
    end
  end

  def load_object

  end

end

