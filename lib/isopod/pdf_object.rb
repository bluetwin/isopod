class Isopod::PdfObject
  IDENT = /\d+ \d+ obj/
  DELIMIT = "endobj"

  def initialize(io, offset)
    @content = nil
    io.seek(offset.to_i, IO::SEEK_SET)
    load(io)
  end

  def load(io)
    tok = io.readline
    puts "loading PdfObject tok: #{tok} match: #{tok.match(IDENT)}"
    if tok.match(IDENT)
      puts "consuming object"
      @number, @gen = tok.scan(/\d+/)
      consume(io)
    end
  end

  def consume(io)
    tok = io.readline
    while !tok.include?(DELIMIT) && !io.eof?
     add_data(tok)
     tok = io.readline unless io.eof?
    end
  end
 
   def add_data(tok)
    if @content.nil?
      @content = tok
    else
      @content << tok
    end
  end


end

