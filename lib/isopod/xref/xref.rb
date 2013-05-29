class Isopod::Xref 
  attr_reader :entries

  def initialize(buffer, offset)
    @buffer = buf
    @buffer.seek(offset, IO::SEEK_SET)
    parse
  end

  def parse
    # peek next token
    if @buffer.peek.eq?('xref')
      # read until trailer hit
      table
    else
      stream
    end
  end

  def table
    @buffer.token
    while !@buffer.peek.eq?("trailer")
      index, count = @buffer.tokens(2)
      load_entries(index, count)
    end
  end

  def build_entries(index, count)
    count.times do |i|
     @entries[index + count] = Isopod::XrefEntry.new(@buffer)
    end
  end

  def stream
    # create stream object

    # decode

    # use data to parse table
  end

end
