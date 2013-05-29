class Isopod::IndirectObject < Isopod::Object
  attr_reader :num, :generation

  LEFT_PAREN = "("
  LESS_THAN = "<"
  STREAM = "stream"
  ID = "ID"
  FWD_SLASH = "/"

  def parse(buf)
    super(buf)
    @num, @generation = @buffer.tokens(2)
    @buffer.token if @buffer.peek.eq?("obj") # Indirect external object
  end
  
  def parse_object
    
  end

end
