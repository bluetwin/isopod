class Isopod::XrefEntry
  attr_reader :offset, :gen, :keyword, :object

  IDENT = /\d+ \d+ (n|f)/

  def initialize(io)
    @io         = io
    @object     = nil
    parse(io.readline)
  end

  def parse(str)
    if str.match(IDENT)
      @offset, @gen, @keyword = str.split(/\s+/)
      load_object
    end
  end

  def load_object
    pos         = @io.pos  # save position to come back
    @object     = PdfObject.new(@io, offset)
    @io.seek pos, IO::SEEK_SET
  end

end

