class Isopod::Document
  attr_reader :header, :body, :trailer, :xref, :object_streams, :startxref
  MAX_REVERSE_SEEK = 1024  
  STARTXREF_INDEX  = 2  

  def initialize(io)
    @io 	= io
    @buffer	= Isopod::Buffer.new(@io)
    # get startxref and begin parse
  end


  def parse
    @buffer.seek(0, IO::SEEK_END)
    @buffer.tokens(:count=>3, :reverse=>true)

    @io.seek(-1 * MAX_REVERSE_SEEK, IO::SEEK_END)
    data = file.read(MAX_REVERSE_SEEK)
    lines = data.split(/[\n\r]+/).reverse
    raise Execption if lines[STARTXREF_INDEX] != 'startxref'
    @startxref = lines[STARTXREF_INDEX-1]
  end
  
  def find_startxref
    @buffer.seek(0, IO::SEEK_END) # Move to end of file
    @buffer.tokens(:count=>3, :reverse=>true) # pull last three tokens["%%EOF", "<byte_offset>", "startxref"]
    @startxref = @buffer[1]
  end

  def fetch_xref
    # decide if we have an xref table or stream
    # peek the next token: 
    #   'xref': we have an xref table
    #   '/\d? \d? obj/': we have a stream
    # This should be left to the xref object to determine
    @xref = Xref.new(@buffer, @startxref)
  end

end
