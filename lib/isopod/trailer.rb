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

  end

  def seek_trailer io
    
  end

end


