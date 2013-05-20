class Isopod::XrefSubSection
  IDENT = /\d+ \d+/
  def initialize io
    @first_obj = @count = nil
    @entries   = []
    load io
  end
  def empty?
   @entries.size == 0
  end
  def load io
    tok = io.readline
    if tok.match(IDENT)
      @first_obj, @count = tok.scan(/\d+/).map{ |v| v.to_i }
      load_entries io
    end
  end

  def load_entries io
    @entries = []
    @count.times do |i|
      @entries << XrefEntry.new(io)
    end
  end

end

