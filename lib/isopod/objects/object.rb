class Isopod::Object
  attr_accessor :data

  def initialize(buf)
    @data 	= ""
    @buffer 	= buf
  end

end
