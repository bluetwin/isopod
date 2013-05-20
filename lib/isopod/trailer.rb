class Isopod::Trailer

  attr_reader :startxref, :dict

  @startxref 	= nil
  @dict		= {}
  STARTXREF_OFFSET 	= 3  
  EOF			= -6   
  BYTE_OFFSET		= -12
  TAIL_BUF_LENGTH = 1 << 16

  def initialize
  
  end
  
  def parse io
    io.extend(File::Tail)
    # parse 3 lines for byte_offset
    io.backwards(STARTXREF_OFFSET)
    lines = io.tail(STARTXREF_OFFSET).map! {|l| l.chomp!}
    if lines.first == "startxref"
      @startxref = lines[1].to_i
    end

    seek_trailer io
  end

  def seek_trailer io
    
  end

end


