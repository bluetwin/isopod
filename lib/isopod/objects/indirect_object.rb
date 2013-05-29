class Isopod::IndirectObject < Isopod::Object
  attr_reader :num, :generation, :contents

  LEFT_PAREN = "("
  LESS_THAN = "<"
  STREAM = "stream"
  ID = "ID"
  FWD_SLASH = "/"

  def initialize(buf)
    super(buf)
  end

  def parse
    @num, @generation = @buffer.tokens(2)
    @buffer.token if @buffer.peek.eq?("obj") # Indirect external object
  end
  
  def content
   while @buffer.peek.eq?('endobj')
     # peek next object then parse
     
   end 
   
  end

end
