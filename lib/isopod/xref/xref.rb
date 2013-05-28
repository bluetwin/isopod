class Isopod::Xref 
  attr_reader :entries

  def initialize(buffer)
    @buffer = buf
    parse
  end

  def parse
    # peek next token
    if @buffer.peek.include?('xref')
      load_table
    else
      load_stream
    end
  end

  def load_table
    
  end

end
